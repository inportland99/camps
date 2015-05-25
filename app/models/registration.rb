class Registration < ActiveRecord::Base

  attr_accessor :stripe_card_token, :location, :process_without_payment

  has_and_belongs_to_many :camp_offerings
  belongs_to :location

  validates :emergency_contact_name, :emergency_contact_phone, :parent_address_1, :parent_email,
            :parent_first_name, :parent_last_name, :parent_phone, :student_first_name, :student_grade,
            :student_last_name, :presence => {:message => ' cannot be blank, Registration not saved'}

  US_STATES = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

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

  def discount_amount
    coupon = CouponCode.find_by_name(coupon_code.upcase)
    camp_count = camp_offerings.count
    if coupon
      case coupon.coupon_type.to_i
      when 0
        camp_count.to_f * 10.0
      when 1
        (total/100).to_f * 0.1
      else
        0.0
      end
    else
      0.0
    end
  end

  def parent_name
    parent_first_name + " " + parent_last_name
  end

  def student_name
    student_first_name + " " + student_last_name
  end

  # def camp_count
  #   sum{|reg| reg.camp_offerings.count{|co| unless co.extended_care?}}
  # end

  def one_camp_halfday?
    camp_count == 1 && ( camp_offerings.first.time == "AM" || camp_offerings.first.time == "PM" )
  end

  def campaign_finished
    update_attribute :camp_campaign, true
  end

  def infusionsoft_actions
    result = Infusionsoft.data_query_order_by('Contact', 50, 0, {:Email=> '%'+"#{self.parent_email}"+'%'}, [:Id, :FirstName, :LastName, :ContactType, :Email], :FirstName, true)
    if result.empty?
      #create new contact
      data = { :FirstName => self.parent_first_name, :LastName => self.parent_last_name, :Email => self.parent_email, :Phone1 => self.parent_phone }
      if contact = Infusionsoft.contact_add(data)
        Infusionsoft.email_optin(self.parent_email, "Program enrollment.")
      end
    else
      contact = result.first["Id"].to_i
    end

    if Rails.env.production?
      #add to group when in production
      Infusionsoft.contact_add_to_group(contact, 1836)
      Infusionsoft.contact_add_to_group(contact, 91) if newsletter?
    elsif Rails.env.development?
      #add to group when in development
      Infusionsoft.contact_add_to_group(contact, 107)
    end
  end
end
