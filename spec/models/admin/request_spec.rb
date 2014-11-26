require 'rails_helper'

RSpec.describe Admin::Request, :type => :model do

  it { is_expected.to have_many :request_positions }
  it { is_expected.to have_one :invoice }
  it { is_expected.to accept_nested_attributes_for :request_positions }

  describe "methods" do
    describe ".merge(requests)" do
      let!(:requests) { create_list(:admin_request, 2) }

      context "when parameters are passed" do
        it "creates a new request" do
          params = [requests[0].id, requests[1].id]

          expect{Admin::Request.merge(params)}.to change(Admin::Request, :count).by(-1)
        end

        it "merges requests" do
          params = [requests[0].id, requests[1].id]
          Admin::Request.merge(params)
          merged_request = Admin::Request.last
          expect(merged_request.request_positions[0].article).to eq requests[0].request_positions[0].article
          expect(merged_request.request_positions[1].article).to eq requests[0].request_positions[1].article
          expect(merged_request.request_positions[2].article).to eq requests[1].request_positions[0].article
          expect(merged_request.request_positions[3].article).to eq requests[1].request_positions[1].article
        end
      end

      context "when parameters are not passed" do
        it "doesn't create a new request" do
          expect{Admin::Request.merge(nil)}.not_to change(Admin::Request, :count)
        end
      end
    end

  end

end
