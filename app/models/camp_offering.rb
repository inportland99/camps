class CampOffering < ActiveRecord::Base
  attr_accessible :assistant, :camp_id, :end_date, :location_id, :start_date, :teacher

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  def name
    camp.title
  end
end
