class Admin::Invoice < ActiveRecord::Base

  has_many :invoice_positions
  belongs_to :request, class_name: "Admin::Request"
  accepts_nested_attributes_for :invoice_positions, allow_destroy: true

  after_create :execute_request

  paginates_per 2

  private

    def execute_request
      unless self.request_id.nil?
        request.executed!
      end
    end
end
