# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_invoice_position, :class => 'Admin::InvoicePosition' do
    article_id 1
    quantity 4
    price 1.5
  end
end
