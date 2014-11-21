require 'rails_helper'

RSpec.describe Admin::Invoice, :type => :model do

  it { is_expected.to have_many :invoice_positions }

end
