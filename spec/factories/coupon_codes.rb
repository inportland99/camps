# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :coupon_code do
    name "MyString"
    type ""
    description "MyText"
    amount 1
  end
end
