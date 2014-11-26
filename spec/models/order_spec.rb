require 'rails_helper'

RSpec.describe Order, :type => :model do

  it { is_expected.to have_many :order_positions }
  it { is_expected.to belong_to :user }

end
