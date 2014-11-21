FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Buyer#{n}" }
    password "dfgcvbdfg"
    password_confirmation "dfgcvbdfg"
    admin false
  end
end
