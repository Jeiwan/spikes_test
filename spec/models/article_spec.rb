require 'rails_helper'

RSpec.describe Article, :type => :model do

  it { is_expected.to have_many :admin_invoice_positions }
  it { is_expected.to have_many :order_positions }
  it { is_expected.to have_many :request_positions }
  it { is_expected.to have_one :product }

end
