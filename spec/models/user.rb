require 'rails_helper'

RSpec.describe User, :type => :model do

  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to have_many :orders }

end
