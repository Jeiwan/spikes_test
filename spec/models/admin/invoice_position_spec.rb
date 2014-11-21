require 'rails_helper'

RSpec.describe Admin::InvoicePosition, :type => :model do

  it { is_expected.to validate_presence_of :article_id }
  it { is_expected.to validate_presence_of :quantity }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :article_id }
  it { is_expected.to validate_numericality_of :quantity }
  it { is_expected.to validate_numericality_of :price }

end
