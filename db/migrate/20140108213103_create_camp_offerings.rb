class CreateCampOfferings < ActiveRecord::Migration[6.0]
  def change
    create_table :camp_offerings do |t|
      t.integer :camp_id
      t.string :teacher
      t.string :assistant
      t.date :start_date
      t.date :end_date
      t.integer :location_id

      t.timestamps
    end
  end
end
