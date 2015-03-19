class AddNewsletterToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :newsletter, :boolean, default: false
  end
end
