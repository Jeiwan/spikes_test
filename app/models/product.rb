class Product < ActiveRecord::Base

  belongs_to :article
  belongs_to :product_stack

  validates :name, presence: true
  validates :price, presence: true, numericality: true

  def self.sell(options = {})
    product_stack = self.find(options[:product]).product_stack
    product_stack.decrement(:quantity, options[:quantity].to_i).save!
  end

end
