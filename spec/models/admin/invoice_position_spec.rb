require 'rails_helper'

RSpec.describe Admin::InvoicePosition, :type => :model do

  it { is_expected.to belong_to :article }
  it { is_expected.to belong_to :invoice }
  it { is_expected.to validate_presence_of :article_id }
  it { is_expected.to validate_numericality_of :article_id }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }
  it { is_expected.to validate_presence_of :quantity }
  it { is_expected.to validate_numericality_of :quantity }

  describe "after_save" do
    let(:article) { create(:article)  }
    let(:invoice_position) { create(:admin_invoice_position, article_id: article.id)  }

    it "receives create_product method" do
      expect(invoice_position).to receive(:create_product)
      invoice_position.save
    end

    context "when product doesn't exist" do
      it "creates a new product stack" do
        expect{invoice_position.save}.to change(ProductStack, :count).by(1)
      end

      it "creates a new product" do
        expect{invoice_position.save}.to change(Product, :count).by(1)
      end
    end

    context "when product already exists" do
      let(:product) { create(:product, article: article, name: article.name) }
      let!(:product_stack) { create(:product_stack, product: product)  }

      it "doesn't create a new product stack" do
        expect{invoice_position.save}.not_to change(ProductStack, :count)
      end

      it "doesn't a new product" do
        expect{invoice_position.save}.not_to change(Product, :count)
      end

      it "increases quantity in a stack" do
        expect{invoice_position.save}.to change{product_stack.reload.quantity}.by(invoice_position.quantity)
      end
    end
  end
end
