class AddPaymentPlanCompletedToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :payment_plan_completed, :boolean, default: false
  end
end
