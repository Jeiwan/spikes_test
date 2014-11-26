class Product < ActiveRecord::Base

  belongs_to :article
  belongs_to :product_stack

  validates :name, presence: true
  validates :price, presence: true, numericality: true

end
