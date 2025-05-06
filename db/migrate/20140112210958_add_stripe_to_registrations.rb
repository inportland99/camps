class AddStripeToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :stripe_customer_token, :string
  end
end
