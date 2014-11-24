# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_invoice_position, :class => 'Admin::InvoicePosition' do
    quantity 4
    price 1.5
    article
  end
end
