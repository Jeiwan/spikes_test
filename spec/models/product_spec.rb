require 'rails_helper'

RSpec.describe Product, :type => :model do

  it { is_expected.to belong_to :article }
  it { is_expected.to belong_to :product_stack }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }

end
