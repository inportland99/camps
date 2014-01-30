class AddCouponTypeToCouponCodes < ActiveRecord::Migration
  def change
    add_column :coupon_codes, :coupon_type, :string
  end
end
