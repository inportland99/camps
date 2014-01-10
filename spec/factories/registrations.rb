# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    parent_first_name "MyString"
    parent_last_name "MyString"
    parent_address_1 "MyString"
    parent_address_2 "MyString"
    parent_email "MyString"
    parent_phone "MyString"
    student_first_name "MyString"
    student_last_name "MyString"
    student_grade "MyString"
    student_allergies "MyString"
    emergency_contact_name "MyString"
    emergency_contact_phone "MyString"
  end
end
