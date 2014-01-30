class CouponCode < ActiveRecord::Base
  attr_accessible :amount, :description, :name, :coupon_type, :active

  validates :name, uniqueness: true

  before_save :upcase_name

  DISCOUNT_TYPE = ["$ Discount", "% Discount"]

  def upcase_name
    self.name = name.upcase
  end
end
