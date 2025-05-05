# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :camp do
    title "MyString"
    description "MyText"
    capacity 1
    age "MyString"
  end
end
