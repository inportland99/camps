class AddStripeChargeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :stripe_charge_token, :string
  end
end
