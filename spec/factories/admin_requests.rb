# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_request, :class => 'Admin::Request' do
    status 0
    request_positions { build_list(:admin_request_position, 2) }
  end
end
