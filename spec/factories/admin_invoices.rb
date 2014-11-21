# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_invoice, :class => 'Admin::Invoice' do
    invoice_positions { build_list(:admin_invoice_position, 3) }
  end
end
