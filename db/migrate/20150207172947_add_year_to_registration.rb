class AddYearToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :year, :integer
  end
end
