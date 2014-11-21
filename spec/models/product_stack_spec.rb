require 'rails_helper'

RSpec.describe ProductStack, :type => :model do

  it { is_expected.to have_one :product }

end
