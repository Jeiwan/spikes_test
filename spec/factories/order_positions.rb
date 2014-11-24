# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_position do
    article_id 1
    quantity 1
    price 1.5
  end
end
