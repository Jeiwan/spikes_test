class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_positions

  def fill_from_cart(cart)
    cart.each do |product|
      self.order_positions.create(article_id: product['article'], quantity: product['quantity'], price: product['price'])
      Product.find(product['id']).sell(product['quantity'])
    end
  end
end
