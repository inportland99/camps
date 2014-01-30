class CreateCouponCodes < ActiveRecord::Migration
  def change
    create_table :coupon_codes do |t|
      t.string :name, :unique => true
      t.string :type
      t.text :description
      t.integer :amount

      t.timestamps
    end
  end
end
