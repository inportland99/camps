class AddCouponUidToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :coupon_uid, :string, default: ""
    add_column :coupon_codes, :uid, :string, default: ""
  end
end
