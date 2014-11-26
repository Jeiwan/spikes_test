class Article < ActiveRecord::Base

  has_many :admin_invoice_positions, class_name: "Admin::InvoicePosition"
  has_many :order_positions
  has_many :request_positions, class_name: "Admin::RequestPosition"
  has_one :product

end
