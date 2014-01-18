class CampOffering < ActiveRecord::Base
  attr_accessible :assistant, :camp_id, :end_date, :location_id, :start_date, :teacher,
                  :classroom, :week, :time

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  OFFERING_TIMES = ["All Day","AM","PM"]

  OFFERING_WEEKS = {
                          1 => {
                                  :start => Date.new(2014,6,9),
                                  :end => Date.new(2014,6,13)
                          },
                          2 => {
                                  :start => Date.new(2014,6,16),
                                  :end => Date.new(2014,6,20)
                          },
                          3 => {
                                  :start => Date.new(2014,6,23),
                                  :end => Date.new(2014,6,30)
                          },
                          4 => {
                                  :start => Date.new(2014,6,16),
                                  :end => Date.new(2014,6,20)
                          },
                          5 => {
                                  :start => Date.new(2014,6,16),
                                  :end => Date.new(2014,6,20)
                          },
                          6 => {
                                  :start => Date.new(2014,6,16),
                                  :end => Date.new(2014,6,20)
                          }
  }

  def name
    camp.title + ": " + location.name + ", " + time + " (Start Date: #{start_date.strftime('%b, %d')})"
  end

  def edit_name
    camp.title + " " + location.name + " Week: " + week.to_s + " " + time
  end

  def students
    students = Array.new
    registrations.each do |r|
      students << "#{r.student_first_name} #{r.student_last_name}"
    end
    students
  end

  def self.by_week(location, week)
    where("location_id=? AND week=?", location, week)
  end

  def price
    camp.price
  end

  def open_spots
    camp.capacity - registrations.count
  end

  def at_capacity?
    open_spots <= 0 ? true : false
  end
end
