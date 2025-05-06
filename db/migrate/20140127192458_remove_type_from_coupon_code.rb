class RemoveTypeFromCouponCode < ActiveRecord::Migration[6.0]
  def up
    remove_column :coupon_codes, :type
  end

  def down
    add_column :coupon_codes, :type, :string
  end
end
