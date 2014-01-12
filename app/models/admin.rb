class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :location_id, :password, :password_confirmation

  belongs_to :location
end
