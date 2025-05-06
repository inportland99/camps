# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!({:email=>"info@mathplusacademy.com", :password=>"mathplus", :password_confirmation => "mathplus"})

Location.create({:name=>"Online", :email=>"info@mathplusacademy.com", :telephone=>"614-792-6284"})
