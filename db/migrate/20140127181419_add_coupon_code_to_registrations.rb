class AddCouponCodeToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :coupon_code, :string
  end
end
