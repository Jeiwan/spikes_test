# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_invoice, :class => 'Admin::Invoice' do
    completed false
  end
end
