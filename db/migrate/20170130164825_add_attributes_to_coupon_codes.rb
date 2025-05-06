class AddAttributesToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_codes, :half_day_discount, :integer, default: 0
    add_column :coupon_codes, :full_day_discount, :integer, default: 0
  end
end
