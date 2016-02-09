class AddPaymentPlanToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :payment_plan, :boolean, default: false
  end
end
