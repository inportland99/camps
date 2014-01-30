class RemoveTypeFromCouponCode < ActiveRecord::Migration
  def up
    remove_column :coupon_codes, :type
  end

  def down
    add_column :coupon_codes, :type, :string
  end
end
