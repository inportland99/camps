class AddCouponCodeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :coupon_code, :string
  end
end
