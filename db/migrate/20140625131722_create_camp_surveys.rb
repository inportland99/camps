class CreateCampSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :camp_surveys do |t|
      t.integer :staisfaction
      t.text :comment
      t.text :improvements
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :student_name
      t.string :grade_completed
      t.string :phone
      t.string :email
      t.time :contact_time
      t.string :preferred_contact
      t.boolean :contact_fall

      t.timestamps
    end
  end
end
