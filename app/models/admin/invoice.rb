class Admin::Invoice < ActiveRecord::Base

  belongs_to :request, class_name: "Admin::Request"
  has_many :invoice_positions
  accepts_nested_attributes_for :invoice_positions, allow_destroy: true

  after_create :execute_request

  paginates_per 10

  private

    def execute_request
      request.executed! if request.present?
    end
end
