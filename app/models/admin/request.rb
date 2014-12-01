class Admin::Request < ActiveRecord::Base

  has_one :invoice, class_name: "Admin::Invoice"
  has_many :request_positions, class_name: "Admin::RequestPosition"
  accepts_nested_attributes_for :request_positions, allow_destroy: true

  enum status: {fresh: 0, pending: 1, executed: 2}

  def self.merge(requests)
    if requests
      merged_request = Admin::Request.new
      merged_request.request_positions_attributes = get_positions_from_requests(requests)
      merged_request.save
    end
  end

  def build_invoice_and_add_positions
    new_invoice = build_invoice
    new_invoice.invoice_positions_attributes = self.request_positions.map do |request_position|
      {article_id: request_position.id, quantity: request_position.quantity}
    end
    new_invoice
  end

  private

    def self.get_positions_from_requests(requests)
      requests.inject([]) do |all_positions, request_id|
        all_positions += collect_positions_from_request(Admin::Request.find(request_id.to_i))
      end
    end

    def self.collect_positions_from_request(request)
      positions = request.request_positions.map do |request_position|
        request_position.attributes.select { |key| ["article_id", "quantity"].include?(key) }
      end
      request.destroy
      positions
    end
end
