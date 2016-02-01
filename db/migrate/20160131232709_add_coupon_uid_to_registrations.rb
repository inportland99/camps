class AddCouponUidToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :coupon_uid, :string, default: ""
    add_column :coupon_codes, :uid, :string, default: ""
  end
end
