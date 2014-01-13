class AddStripeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :stripe_customer_token, :string
  end
end
