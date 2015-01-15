# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :camp_interest do
    name "MyString"
    email "MyString"
    year 1
    newsletter false
  end
end
