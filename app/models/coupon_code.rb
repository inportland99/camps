class CouponCode < ActiveRecord::Base

  extend Dragonfly::Model
  dragonfly_accessor :image

  validates :name, uniqueness: true

  before_save :upcase_name

  DISCOUNT_TYPE = ["$ Discount", "% Discount"]

  def upcase_name
    name = name.upcase
  end

  def how_many_used?
    title = name
    count = 0
    Registration.where(year: 1).each do |reg|
      if reg.coupon_code && reg.coupon_code.upcase == title
        count += 1
      end
    end
    count
  end


  def generate_share_image
    # Read coupon.svg file
    file = File.read('app/assets/images/coupons/coupon.svg')

    #create custom coupon code using last name of parent
    coupon_code = name

    # Add custom coupon code to coupon.svg information
    file = file.gsub('CouponCode', coupon_code)

    # create new file and add edited info
    File.open('tmp/coupon.svg', 'w'){ |f| f.write(file) }
    new_file = File.open('tmp/coupon.svg')

    #save to s3
    result = Dragonfly.app.store(new_file, {}, path: "images/#{coupon_code}.svg", headers: {'x-amz-acl' => 'public-read-write'})

    update_attribute :image_uid, result

    File.delete(new_file)

    result
  end

  def self.generate_name(string)
    if string.length > 3
      name = string.downcase[0..3] + rand(1000..2000).to_s
    elsif string.length == 3
      name = string.downcase[0..2] + rand(1000..2000).to_s
    end
  end
end
