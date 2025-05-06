class AddNewsletterToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :newsletter, :boolean, default: false
  end
end
