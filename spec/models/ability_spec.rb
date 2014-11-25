require 'rails_helper'

RSpec.shared_examples "guest abilities" do
  it { is_expected.to be_able_to :read, Product }

  it { is_expected.not_to be_able_to :manage, :all }
end

describe Ability do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  describe "guest" do
    it_behaves_like "guest abilities"
  end

  describe "user" do
    let(:user) { create(:user) }

    it_behaves_like "guest abilities"

    it { is_expected.to be_able_to :create, Order }
    it { is_expected.to be_able_to :add_to_cart, Product }
    it { is_expected.to be_able_to :remove_from_cart, Product }
    it { is_expected.to be_able_to :cart, User }
  end

  describe "admin" do
    let(:user) { create(:user, admin: true) }

    it { is_expected.to be_able_to :manage, :all }
  end
end
