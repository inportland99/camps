# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create({:name=>"SuperAdmin"})
Location.create({:name=>"Online", :email=>"help@mathplusacademy.com", :telephone=>"614-792-6284"})
User.create!({:email=>"help@mathplusacademy.com", :password=>"mathplus", :password_confirmation => "mathplus",location_id: 1})

