namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'faker'

    make_roles
    make_users
    # if Rails.env.development?
      make_camps
      make_camp_offerings
      make_locations
      make_registrations
      make_coupon_codes
    # end
  end

  desc "Fill database with sample data"
  task weekly_programs: :environment do
    make_weekly_programs
  end
end

def make_roles
    Role.create!(name: "SuperAdmin")
    Role.create!(name: "Admin")
    Role.create!(name: "Employee")
    Role.create!(name: "Customer")
    Role.create!(name: "Guest")
end

#this is where we add the user information
def make_users
    user1 = User.create!(first_name:            "Kyra",
                         last_name:             "wisniewski",
                         location_id:           "2",
                         email:                 "kyrawisniewski@gmail.com",
                         password:              "password",
                         password_confirmation: "password")
    user1.roles << Role.find(2)
    user1.save

    user2 = User.create!(first_name:            "Madison",
                         last_name:             "Corna",
                         location_id:           "1",
                         email:                 "madison@mathplusacademy.com",
                         password:              "password",
                         password_confirmation: "password")
    user2.roles << Role.find(1)
    user2.save

    user3 = User.create!(first_name:            "Raj",
                         last_name:             "Shah",
                         location_id:           "1",
                         email:                 "raj@mathplusacademy.com",
                         password:              "password",
                         password_confirmation: "password")
    user3.roles << Role.find(1)
    user3.save
end



def make_camps
  16.times do |n|
  Camp.create!(title:           "Camp #{n+1}",
               description:     Faker::Lorem.sentences.first,
               capacity:        8,
               age:             "K-8",
               price:           n == 0 ? 394 : 197)
  end
end

def make_camp_offerings
  3.times do |n|
    CampOffering.create!(camp_id:           1,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       1,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "All Day",
                         classroom:         1,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           1,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       2,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "All Day",
                         classroom:         1,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           2,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       1,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "AM",
                         classroom:         2,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           3,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       1,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "AM",
                         classroom:         3,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           2,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       2,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "AM",
                         classroom:         2,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           3,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       2,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "AM",
                         classroom:         3,
                         week:              n + 1,
                         year:              1)
  end
  #begin PM
  3.times do |n|
    CampOffering.create!(camp_id:           4,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       1,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "PM",
                         classroom:         2,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           5,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       1,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "PM",
                         classroom:         3,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           4,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       2,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "PM",
                         classroom:         2,
                         week:              n + 1,
                         year:              1)
  end
  3.times do |n|
    CampOffering.create!(camp_id:           5,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       2,
                         start_date:        Date.new(2014,6,9) + n.weeks,
                         end_date:          Date.new(2014,6,13) + n.weeks,
                         time:              "PM",
                         classroom:         3,
                         week:              n + 1,
                         year:              1)
  end
end

def make_registrations
  16.times do |n|
    r = Registration.create!(parent_first_name:       Faker::Name.first_name,
                             parent_last_name:        Faker::Name.last_name,
                             parent_address_1:        Faker::Address.street_address,
                             parent_city:             Faker::Address.city,
                             parent_state:            Faker::Address.state,
                             parent_zip:              Faker::Address.zip,
                             parent_email:            Faker::Internet.email,
                             parent_phone:            Faker::PhoneNumber.cell_phone,
                             student_first_name:      Faker::Name.first_name,
                             student_last_name:       Faker::Name.last_name,
                             student_grade:           ["KG", 1, 2, 3, 4, 5].sample,
                             emergency_contact_name:  Faker::Name.first_name,
                             emergency_contact_phone: Faker::PhoneNumber.cell_phone,
                             location_id:             ((n+1)%2)+1,
                             total:                   CampOffering.find(((n+1)%2)+1).price
      )
    r.camp_offerings << CampOffering.find(((n+1)%2)+1)
    r.save
  end
end

def make_locations
  Location.create!(name:          "Powell",
                   address_1:     "9681 Sawmill Road",
                   city:          "Powell",
                   state:         "Ohio",
                   zip:           "43065",)

  Location.create!(name:          "New Albany",
                   address_1:     "5346 North Hamilton Road",
                   city:          "Columbus",
                   state:         "Ohio",
                   zip:           "43230",)
end

def make_coupon_codes
  coupon = CouponCode.create!(name: "10DOLLARSOFF",
                     coupon_type: "0",
                     amount: 10,
                     description: "Dollar amount off.")
  coupon.toggle!(:active)

  coupon1 = CouponCode.create!(name: "10PERCENTOFF",
                     coupon_type: "1",
                     amount: 10,
                     description: "Percentage off.")
  coupon1.toggle!(:active)
end

def make_weekly_programs
  WeeklyProgram.create!(name: "Math Enrichment (KG - Algebra)")
  WeeklyProgram.create!(name: "Math Team")
  WeeklyProgram.create!(name: "LEGO Robotics")
  WeeklyProgram.create!(name: "Programming Lab")
  WeeklyProgram.create!(name: "Chess")
end
