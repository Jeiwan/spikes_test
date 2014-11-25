class Admin::Request < ActiveRecord::Base

  has_many :request_positions, class_name: "Admin::RequestPosition"
  has_one :invoice, class_name: "Admin::Invoice"
  accepts_nested_attributes_for :request_positions

  enum status: {fresh: 0, pending: 1, executed: 2}
end
