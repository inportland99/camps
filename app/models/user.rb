class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles
  belongs_to :location

  ROLES = %w[super_admin admin employee customer guest]

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
