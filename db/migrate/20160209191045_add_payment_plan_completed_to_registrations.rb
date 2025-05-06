class AddPaymentPlanCompletedToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :payment_plan_completed, :boolean, default: false
  end
end
