class AddPaymentPlanToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :payment_plan, :boolean, default: false
  end
end
