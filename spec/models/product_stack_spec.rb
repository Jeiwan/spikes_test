require 'rails_helper'

RSpec.describe ProductStack, :type => :model do

  it { is_expected.to have_one :product }
  it { is_expected.to validate_presence_of :quantity }
  it { is_expected.to validate_numericality_of :quantity }
  it { is_expected.to validate_numericality_of :quantity_threshold }

  describe "after update" do
    let(:product) { create(:product) }
    let(:product_stack) { product.product_stack }

    it "receives check_limits_and_make_request" do
      expect(product_stack).to receive(:check_limits_and_make_request)
      product_stack.save
    end

    context "when quantity is changed" do
      context "when quantity is low" do
        it "creates a new request" do
          product_stack.decrement(:quantity, 1)
          expect{product_stack.save}.to change(Admin::Request, :count).by(1)
        end
        it "creates a new request position" do
          product_stack.decrement(:quantity, 1)
          expect{product_stack.save}.to change(Admin::RequestPosition, :count).by(1)
        end
      end

      context "when quantity is not low" do
        it "doesn't create a new request" do
          expect{product_stack.save}.not_to change(Admin::Request, :count)
          expect{product_stack.save}.not_to change(Admin::RequestPosition, :count)
        end
      end

      context "when product quantity threshold is set" do
        before do
          product_stack.update(quantity_threshold: 5)
        end

        context "when quanity is low" do
          it "creates a new request" do
            product_stack.decrement(:quantity, 7)
            expect{product_stack.save}.to change(Admin::Request, :count).by(1)
          end
          it "creates a new request position" do
            product_stack.decrement(:quantity, 7)
            expect{product_stack.save}.to change(Admin::RequestPosition, :count).by(1)
          end
        end
        context "when quantity is not low" do
          it "doesn't create a new request" do
            product_stack.decrement(:quantity, 5)
            expect{product_stack.save}.not_to change(Admin::Request, :count)
            expect{product_stack.save}.not_to change(Admin::RequestPosition, :count)
          end
        end
      end
    end

    context "when quantity is not changed" do
      it "doesn't create a new request" do
        expect{product_stack.save}.not_to change(Admin::Request, :count)
        expect{product_stack.save}.not_to change(Admin::RequestPosition, :count)
      end
    end
  end
end
