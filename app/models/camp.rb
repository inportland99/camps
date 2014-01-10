class Camp < ActiveRecord::Base
  attr_accessible :age, :capacity, :description, :title, :price

  has_many :camp_offerings
end
