require 'rails_helper'

RSpec.describe Product, :type => :model do

  it { is_expected.to belong_to :article }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }

  describe "methods" do
    describe ".sell({product: 1, quantity: 1})" do
      let(:product) { create(:product) }

      it "decrements product's quantity" do
        expect{product.sell(1)}.to change{product.reload.quantity}.by(-1)
      end
    end
  end
  describe "after update" do
    let(:product) { create(:product) }

    it "receives check_limits" do
      expect(product).to receive(:check_limits)
      product.save
    end

    context "when quantity is changed" do
      context "when quantity is low" do
        it "creates a new request" do
          product.decrement(:quantity, 1)
          expect{product.save}.to change(Admin::Request, :count).by(1)
        end
        it "creates a new request position" do
          product.decrement(:quantity, 1)
          expect{product.save}.to change(Admin::RequestPosition, :count).by(1)
        end
      end

      context "when quantity is not low" do
        it "doesn't create a new request" do
          expect{product.save}.not_to change(Admin::Request, :count)
          expect{product.save}.not_to change(Admin::RequestPosition, :count)
        end
      end

      context "when product quantity threshold is set" do
        before do
          product.update(quantity_threshold: 5)
        end

        context "when quanity is low" do
          it "creates a new request" do
            product.decrement(:quantity, 7)
            expect{product.save}.to change(Admin::Request, :count).by(1)
          end
          it "creates a new request position" do
            product.decrement(:quantity, 7)
            expect{product.save}.to change(Admin::RequestPosition, :count).by(1)
          end
        end
        context "when quantity is not low" do
          it "doesn't create a new request" do
            product.decrement(:quantity, 5)
            expect{product.save}.not_to change(Admin::Request, :count)
            expect{product.save}.not_to change(Admin::RequestPosition, :count)
          end
        end
      end
    end

    context "when quantity is not changed" do
      it "doesn't create a new request" do
        expect{product.save}.not_to change(Admin::Request, :count)
        expect{product.save}.not_to change(Admin::RequestPosition, :count)
      end
    end
  end
end
