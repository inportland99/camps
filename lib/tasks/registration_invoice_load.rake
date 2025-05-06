namespace :test_run do
  desc "Send weekly registration report."
  task registration_and_invoice_process: :environment do
    if Rails.env.development?
      test_registration_invoice_processes
    else
      production_warning
    end
  end
end

def test_registration_invoice_processes
  bad_card = "4000000000000341"
  good_card = "4242424242424242"


  12.times do |n|
    n%2 == 0 ? card_number = bad_card : card_number = good_card

    email = Faker::Internet.email
    parent_first_name = Faker::Name.first_name
    parent_last_name = Faker::Name.last_name
    student_first_name = Faker::Name.first_name
    student_last_name = parent_last_name
    student_grade = ["KG", "1", "2", "3", "4", "5", "6", "7" , "8"].sample
    address = Faker::Address.street_name
    city = Faker::Address.city
    state = Faker::Address.state_abbr
    zip = Faker::Address.zip
    parent_phone = Faker::PhoneNumber.cell_phone
    total = 59100
    camp_offerings = CampOffering.where(year: 2, location: Random.new.rand(1..3)).limit(2)
    location = camp_offerings.first.location

    registration = Registration.create( parent_first_name:          parent_first_name,
                                        parent_last_name:           parent_last_name,
                                        parent_address_1:           address,
                                        parent_city:                city,
                                        parent_state:               state,
                                        parent_zip:                 zip,
                                        parent_email:               email,
                                        parent_phone:               parent_phone,
                                        student_first_name:         student_first_name,
                                        student_last_name:          student_last_name,
                                        student_grade:              student_grade,
                                        student_allergies:          "none",
                                        emergency_contact_name:     parent_first_name,
                                        emergency_contact_phone:    parent_phone,
                                        total:                      total,
                                        location_id:                location.id,
                                        year:                       2,
                                        payment_plan:               true
                   )

    registration.camp_offerings << camp_offerings
    registration.save

    camp_names = Array.new
    camp_location = registration.camp_offerings.first.location.name
    registration.camp_offerings.each do |offering|
      camp_names << "#{offering.name} "
    end

    card = Stripe::Token.create(
                                :card => {
                                  :number => card_number,
                                  :exp_month => 2,
                                  :exp_year => 2017,
                                  :cvc => "314"
                                }
                              )

    customer = Stripe::Customer.create(
                                        source:       card.id,
                                        email:        email,
                                        description:  "Purchased #{Date.today.year} Summer Camp."
                                        )

    # Add Stripe customer id to registration
    registration.update_attribute :stripe_customer_id, customer.id

    # Calculate payments for invoices and first charge
    payments = registration.calculate_payments(total)

    3.times do |n|
      invoice = Invoice.create(
                               amount: payments[n],
                               registration_id: registration.id,
                               due_date: Date.today + (n*30).days,
                               stripe_customer_id: customer.id,
                               payment_order: n+1
                )
      invoice.save!
    end

    first_invoice = registration.invoices.first

    begin
    # Charge customer using customer id
      charge = Stripe::Charge.create(
                                      amount: first_invoice.amount,
                                      currency: "usd",
                                      customer: customer.id,
                                      description: "#{camp_location}: Registration #{student_first_name} for #{camp_names.join}."
                                    )

      if charge
        first_invoice.update paid: true, stripe_charge_id: charge.id
        registration.update_attribute :stripe_charge_token, charge.id
      end

    rescue Stripe::CardError => e
      first_invoice.update paid: false, charge_description: e.to_s
    end

  end
end

def production_warning
  puts "You are in production. You do not want to run this task"
end
