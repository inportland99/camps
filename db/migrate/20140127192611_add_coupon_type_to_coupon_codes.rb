class AddCouponTypeToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_codes, :coupon_type, :string
  end
end
