require 'rails_helper'

RSpec.describe OrderPosition, :type => :model do

  it { is_expected.to belong_to :article }
  it { is_expected.to belong_to :order }
  it { is_expected.to validate_numericality_of :price }
  it { is_expected.to validate_numericality_of :quantity }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_presence_of :quantity }

end
