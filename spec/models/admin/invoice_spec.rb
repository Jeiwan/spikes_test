require 'rails_helper'

RSpec.describe Admin::Invoice, :type => :model do

  it { is_expected.to have_many :invoice_positions }
  it { is_expected.to accept_nested_attributes_for :invoice_positions }

end
