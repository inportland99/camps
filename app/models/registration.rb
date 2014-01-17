class Registration < ActiveRecord::Base
  attr_accessible :emergency_contact_name, :emergency_contact_phone, :parent_address_1,
                  :parent_address_2, :parent_email, :parent_first_name, :parent_last_name,
                  :parent_phone, :student_allergies, :student_first_name, :student_grade,
                  :student_last_name, :camp_offering_ids, :stripe_charge_token, :stripe_card_token,
                  :total, :location, :parent_city, :parent_state, :parent_zip

  attr_accessor :stripe_card_token, :location

  has_and_belongs_to_many :camp_offerings

  validates :emergency_contact_name, :emergency_contact_phone, :parent_address_1, :parent_email,
            :parent_first_name, :parent_last_name, :parent_phone, :student_first_name, :student_grade,
            :student_last_name, :presence => {:message => ' cannot be blank, Task not saved'}

  def save_with_payment
    if valid?
      camp_names = Array.new
      charge_total = total * 100
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
end
