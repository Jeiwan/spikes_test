class Admin::InvoicePosition < ActiveRecord::Base

  belongs_to :article
  belongs_to :invoice

  validates :article_id, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true, numericality: true

  after_save :create_product

  private

    def create_product
      product = Product.find_or_initialize_by(article_id: article_id)
      if product.new_record?
        product_stack = ProductStack.create(quantity: quantity)
        product_stack.create_product(article_id: article_id, name: self.article.name, price: price)
      else
        product.product_stack.increment!(:quantity, quantity)
      end
    end
end
