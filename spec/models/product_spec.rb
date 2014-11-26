require 'rails_helper'

RSpec.describe Product, :type => :model do

  it { is_expected.to belong_to :article }
  it { is_expected.to belong_to :product_stack }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }

  describe "methods" do
    describe ".sell({product: 1, quantity: 1})" do
      let(:product) { create(:product) }

      it "decrements product's quantity" do
        expect{product.sell(1)}.to change{product.reload.product_stack.quantity}.by(-1)
      end
    end
    
  end

end
