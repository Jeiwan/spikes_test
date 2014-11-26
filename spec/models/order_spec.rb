require 'rails_helper'

RSpec.describe Order, :type => :model do

  it { is_expected.to have_many :order_positions }
  it { is_expected.to belong_to :user }

  describe "methods" do

    describe "#fill_from_cart(cart)" do
      let(:order) { create(:order) }
      let(:product) { create(:product) }
      let(:cart) do
        [{'article_id' => product.article_id, 'quantity' => 1, 'price' => product.price, 'id' => product.id}]
      end

      it "creates order positions from cart" do
        expect{order.fill_from_cart(cart)}.to change(OrderPosition, :count).by(1)
      end
    end
    
  end

end
