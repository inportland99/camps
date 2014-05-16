class CouponCode < ActiveRecord::Base

  validates :name, uniqueness: true

  before_save :upcase_name

  DISCOUNT_TYPE = ["$ Discount", "% Discount"]

  def upcase_name
    self.name = name.upcase
  end

  def how_many_used?
    title = name
    count = 0
    Registration.all.each do |reg|
      if reg.coupon_code && reg.coupon_code.upcase == title
        count += 1
      end
    end
    count
  end
end
