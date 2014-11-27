class Product < ActiveRecord::Base

  belongs_to :article

  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  validates :quantity_threshold, numericality: true, allow_nil: true

  after_update :check_limits

  def sell(quantity)
    decrement(:quantity, quantity.to_i).save!
  end

  def quantity_limit
    @quantity_limit ||= quantity_threshold || Admin::Setting.find_by(name: "quantity_threshold").value.to_i
  end


  private
    def check_limits
      make_request if quantity_changed? && quantity <= quantity_limit && Admin::RequestPosition.find_by(article_id: article_id).nil?
    end

    def make_request
      Admin::Request.create(status: 0).request_positions.create(article_id: article_id, quantity: quantity_limit)
    end
end
