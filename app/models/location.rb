class Location < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :email, :name, :state, :telephone, :zip

  has_many :camp_offerings
  has_many :users
end
