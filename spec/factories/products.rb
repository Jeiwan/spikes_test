# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "product#{n}" }
    price 1.5
    article
    product_stack { create(:product_stack, quantity: 10) }
  end
end
