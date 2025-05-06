class CreateCampInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :camp_interests do |t|
      t.string :name
      t.string :email
      t.integer :year
      t.boolean :newsletter

      t.timestamps
    end
  end
end
