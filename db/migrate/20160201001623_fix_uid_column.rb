class FixUidColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :coupon_codes, :uid, :image_uid
  end
end
