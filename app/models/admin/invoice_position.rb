class Admin::InvoicePosition < ActiveRecord::Base

  belongs_to :article
  belongs_to :invoice

  validates :article_id, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true, numericality: true

  after_save :create_product

  private

    def create_product
      product = Product.find_or_initialize_by(article: article)
      if product.new_record?
        product.name = article.name
        product.price = price
        product.quantity = quantity
        product.save
      else
        product.increment!(:quantity, quantity)
      end
    end
end
