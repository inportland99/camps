class AddStripeCustomerIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :stripe_customer_id, :string
  end
end
