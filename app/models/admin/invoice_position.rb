class Admin::InvoicePosition < ActiveRecord::Base

  belongs_to :invoice
  belongs_to :article

  validates :article_id, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true, numericality: true

end
