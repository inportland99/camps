namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'faker'

    Rake::Task['db:reset'].invoke
    make_roles
    make_users
    make_camps
    make_camp_offerings
    make_locations
    make_registrations
  end
end

def make_roles
    Role.create!(name: "SuperAdmin")
    Role.create!(name: "Admin")
    Role.create!(name: "Employee")
    Role.create!(name: "Customer")
    Role.create!(name: "Guest")
end

def make_users
    user1 = User.create!(first_name:            "Travis",
                         last_name:             "Sperry",
                         location_id:           "2",
                         email:                 "director@mathplusacademy.com",
                         password:              "password",
                         password_confirmation: "password")
    user1.roles << Role.find(1)
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
    user2.roles << Role.find(1)
    user2.save
end



def make_camps
  8.times do |n|
  Camp.create!(title:           "Camp #{n+1}",
               description:     Faker::Lorem.sentences,
               capacity:        8,
               age:             "K-8",
               price:           197)
  end
end

def make_camp_offerings
  20.times do |n|
    CampOffering.create!(camp_id:           Array(1..8).sample,
                         teacher:           Faker::Name.name,
                         assistant:         Faker::Name.name,
                         location_id:       [1, 2].sample)
  end
end

def make_registrations
  16.times do |n|
    r = Registration.create!(parent_first_name:      Faker::Name.first_name,
                         parent_last_name:       Faker::Name.last_name,
                         parent_address_1:       Faker::Address.street_address,
                         parent_email:           Faker::Internet.email,
                         parent_phone:           Faker::PhoneNumber.cell_phone,
                         student_first_name:     Faker::Name.first_name,
                         student_last_name:      Faker::Name.last_name,
                         student_grade:          ["KG", 1, 2, 3, 4, 5].sample
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


# def make_relationships
#   users = User.all
#   user  = users.first
#   followed_users = users[2..50]
#   followers      = users[3..40]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end