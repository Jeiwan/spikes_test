# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_stack do
    quantity 1
    product
  end
end
