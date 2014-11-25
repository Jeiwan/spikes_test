class Admin::Request < ActiveRecord::Base

  has_many :request_positions, class_name: "Admin::RequestPosition"
  has_one :invoice, class_name: "Admin::Invoice"
  accepts_nested_attributes_for :request_positions

  enum status: {fresh: 0, pending: 1, executed: 2}

  def self.merge(requests)
    if requests
      merged_request = Admin::Request.new
      request_positions = []
      requests.each do |request_id|
        request_to_merge = Admin::Request.find(request_id.to_i)
        request_to_merge.request_positions.find_each do |request_position|
          request_positions << request_position.attributes.select { |key| ["article_id", "quantity"].include?(key) }
        end
        request_to_merge.destroy
      end
      merged_request.request_positions_attributes = request_positions
      merged_request.save
    end
  end
end
