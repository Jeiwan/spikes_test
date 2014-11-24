class OrderPosition < ActiveRecord::Base
  belongs_to :order
  belongs_to :article

  validates :quantity, presence: true
  validates :price, presence: true
end
