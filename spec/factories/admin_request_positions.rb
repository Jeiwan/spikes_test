# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_request_position, :class => 'Admin::RequestPosition' do
    quantity 1
    article { build(:article) }
  end
end
