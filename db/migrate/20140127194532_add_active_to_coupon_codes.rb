class AddActiveToCouponCodes < ActiveRecord::Migration
  def change
    add_column :coupon_codes, :active, :boolean
  end
end
