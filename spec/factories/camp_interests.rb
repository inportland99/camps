# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :camp_interest do
    name "MyString"
    email "MyString"
    year 1
    newsletter false
  end
end
