# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :camp_survey do
    staisfaction 1
    comment "MyText"
    improvements "MyText"
    parent_first_name "MyString"
    parent_last_name "MyString"
    student_name "MyString"
    grade_completed "MyString"
    phone "MyString"
    email "MyString"
    contact_time "2014-06-25 09:17:22"
    preferred_contact "MyString"
    contact_fall false
  end
end
