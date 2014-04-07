class Registration < ActiveRecord::Base
  attr_accessible :emergency_contact_name, :emergency_contact_phone, :parent_address_1,
                  :parent_address_2, :parent_email, :parent_first_name, :parent_last_name,
                  :parent_phone, :student_allergies, :student_first_name, :student_grade,
                  :student_last_name, :camp_offering_ids, :stripe_charge_token, :stripe_card_token,
                  :total, :location_id, :parent_city, :parent_state, :parent_zip,
                  :process_without_payment, :coupon_code

  attr_accessor :stripe_card_token, :location, :process_without_payment

  has_and_belongs_to_many :camp_offerings
  belongs_to :location

  validates :emergency_contact_name, :emergency_contact_phone, :parent_address_1, :parent_email,
            :parent_first_name, :parent_last_name, :parent_phone, :student_first_name, :student_grade,
            :student_last_name, :presence => {:message => ' cannot be blank, Task not saved'}

  US_STATES = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN
                 MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA
                 WI WV WY)

  def save_with_payment
    if valid?
      camp_names = Array.new
      charge_total = total
      camp_location = camp_offerings.first.location.name
      camp_offerings.each do |offering|
        camp_names << "#{offering.name} "
      end
      charge = Stripe::Charge.create(
                                      amount: charge_total,
                                      currency: "usd",
                                      card: stripe_card_token,
                                      description: "#{camp_location}: Registration #{student_first_name} for #{camp_names.join}."
                                    )
      self.stripe_charge_token = charge.id
      save!
    end
  end

  def save_without_payment
    if valid?
      save!
    end
  end

  def parent_name
    parent_first_name + " " + parent_last_name
  end

  def student_name
    student_first_name + " " + student_last_name
  end

  def camp_count
    camp_offerings.count
  end

  def one_camp_halfday?
    camp_count == 1 && ( camp_offerings.first.time == "AM" || camp_offerings.first.time == "PM" )
  end
end