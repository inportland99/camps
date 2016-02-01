class FixUidColumn < ActiveRecord::Migration
  def change
    rename_column :coupon_codes, :uid, :image_uid
  end
end
