class Article < ActiveRecord::Base

  has_many :admin_invoice_positions, class_name: "Admin::InvoicePosition"
  has_one :product

end
