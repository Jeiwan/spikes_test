class ProductStack < ActiveRecord::Base

  has_one :product

  validates :quantity, presence: true, numericality: true
  validates :quantity_threshold, numericality: true, allow_nil: true

  after_update :check_limits_and_make_request

  private
    
    def check_limits_and_make_request
      if quantity_changed?
        limit = quantity_threshold || Admin::Setting.find_by(name: "quantity_threshold").value.to_i
        if quantity <= limit
          unless Admin::RequestPosition.find_by(article_id: product.article_id)
            new_request = Admin::Request.create(status: 0)
            new_request.request_positions.create(article_id: product.article_id, quantity: 10)
          end
        end
      end
    end
end
