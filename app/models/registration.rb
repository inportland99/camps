class Registration < ActiveRecord::Base
  attr_accessible :emergency_contact_name, :emergency_contact_phone, :parent_address_1,
                  :parent_address_2, :parent_email, :parent_first_name, :parent_last_name,
                  :parent_phone, :student_allergies, :student_first_name, :student_grade,
                  :student_last_name, :camp_offering_ids

  has_and_belongs_to_many :camp_offerings
end
