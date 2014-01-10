namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'faker'

    Rake::Task['db:reset'].invoke
    # make_users
    make_camps
    make_camp_offerings
    make_locations
  end
end

# def make_users
#   admin = User.create!(first_name:            "Travis",
#                        last_name:             "Sperry",
#                        role:                  "Admin",
#                        phone:                 "(614) 260-6162",
#                        location_id:           "2",
#                        email:                 "tkendalls@aol.com",
#                        password:              "password",
#                        password_confirmation: "password")
#   admin.toggle!(:admin)
#   admin.toggle!(:active)
# end

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