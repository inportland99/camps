class AddYearToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :year, :integer
  end
end
