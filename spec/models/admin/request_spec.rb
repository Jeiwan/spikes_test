require 'rails_helper'

RSpec.describe Admin::Request, :type => :model do

  it { is_expected.to have_many :request_positions }
  it { is_expected.to accept_nested_attributes_for :request_positions }

end
