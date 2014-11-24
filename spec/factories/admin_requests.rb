# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_request, :class => 'Admin::Request' do
    executed false
    request_positions { build_list(:admin_request_position, 2) }
  end
end
