# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_invoice, class: 'Admin::Invoice' do
    invoice_positions { build_list(:admin_invoice_position, 3) }
  end

  factory :admin_invoice_with_request, class: 'Admin::Invoice' do
    invoice_positions { build_list(:admin_invoice_position, 3) }
    request { build(:admin_request) }
  end
end
