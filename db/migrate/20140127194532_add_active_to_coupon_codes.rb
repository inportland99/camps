class AddActiveToCouponCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :coupon_codes, :active, :boolean
  end
end
