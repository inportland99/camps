# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :camp_offering do
    camp_id 1
    teacher "MyString"
    assistant "MyString"
    start_date "2014-01-08"
    end_date "2014-01-08"
    location_id 1
  end
end
