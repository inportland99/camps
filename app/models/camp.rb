class Camp < ActiveRecord::Base

  has_many :camp_offerings
  has_many :camp_surveys
end
