class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :parent_address_1
      t.string :parent_address_2
      t.string :parent_email
      t.string :parent_phone
      t.string :student_first_name
      t.string :student_last_name
      t.string :student_grade
      t.string :student_allergies
      t.string :emergency_contact_name
      t.string :emergency_contact_phone

      t.timestamps
    end
  end
end
