class OrderPosition < ActiveRecord::Base

  belongs_to :article
  belongs_to :order

  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true

end
