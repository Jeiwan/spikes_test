require 'rails_helper'

RSpec.describe Admin::RequestPosition, :type => :model do

  it { is_expected.to belong_to :request }
  it { is_expected.to belong_to :article }
  it { is_expected.to validate_presence_of :quantity }

end
