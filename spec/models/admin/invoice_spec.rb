require 'rails_helper'

RSpec.describe Admin::Invoice, :type => :model do

  it { is_expected.to belong_to :request }
  it { is_expected.to have_many :invoice_positions }
  it { is_expected.to accept_nested_attributes_for :invoice_positions }

  describe "after_create" do
    let(:invoice) { build(:admin_invoice) }

    it "receives execute_request" do
      expect(invoice).to receive(:execute_request)
      invoice.save
    end

    describe "#execute_request" do
      context "when invoice is created for a request" do
        let(:invoice_with_request) { build(:admin_invoice_with_request) }

        it "executes the request" do
          invoice_with_request.save
          expect(invoice_with_request.request.reload).to be_executed
        end
      end
    end
  end
end
