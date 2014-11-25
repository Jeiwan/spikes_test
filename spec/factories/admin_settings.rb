# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_setting, :class => 'Admin::Setting' do
    name "MyString"
    value "MyString"
  end
end
