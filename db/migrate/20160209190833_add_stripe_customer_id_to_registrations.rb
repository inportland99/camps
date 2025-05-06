class AddStripeCustomerIdToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :stripe_customer_id, :string
  end
end
