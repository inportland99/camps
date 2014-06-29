class CreateWeeklyPrograms < ActiveRecord::Migration
  def change
    create_table :weekly_programs do |t|
      t.string :name

      t.timestamps
    end
  end
end
