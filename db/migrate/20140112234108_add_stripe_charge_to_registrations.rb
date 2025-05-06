class AddStripeChargeToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :stripe_charge_token, :string
  end
end
