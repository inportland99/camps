class Location < ActiveRecord::Base

  has_many :camp_offerings
  has_many :users
  has_many :registrations
  has_many :camp_surveys
end
