class AddAttributesToCouponCodes < ActiveRecord::Migration
  def change
    add_column :coupon_codes, :half_day_discount, :integer, default: 0
    add_column :coupon_codes, :full_day_discount, :integer, default: 0
  end
end
