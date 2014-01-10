class CreateCamps < ActiveRecord::Migration
  def change
    create_table :camps do |t|
      t.string :title
      t.text :description
      t.integer :capacity
      t.string :age

      t.timestamps
    end
  end
end
