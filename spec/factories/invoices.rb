FactoryGirl.define do
  factory :invoice do
    registration_id 1
paid false
payment_date "2016-02-09"
stripe_charge_id "MyString"
stripe_customer_id "MyString"
amount 1
  end

end
