class CampOffering < ActiveRecord::Base

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  OFFERING_TIMES = ["All Day","AM","PM"]

  if Rails.env.development?
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
                                  :end => Date.new(2014,6,27)
                          },
                          4 => {
                                  :start => Date.new(2014,7,7),
                                  :end => Date.new(2014,7,11)
                          },
                          5 => {
                                  :start => Date.new(2014,7,14),
                                  :end => Date.new(2014,7,18)
                          },
                          6 => {
                                  :start => Date.new(2014,7,21),
                                  :end => Date.new(2014,7,25)
                          },
                          7 => {
                                  :start => Date.new(2014,7,28),
                                  :end => Date.new(2014,8,1)
                          },
                          8 => {
                                  :start => Date.new(2014,8,4),
                                  :end => Date.new(2014,8,8)
                          }
  }
  elsif Rails.env.production?
  OFFERING_WEEKS = {
                          1 => {
                                  :start => Date.new(2015,6,8),
                                  :end => Date.new(2015,6,12)
                          },
                          2 => {
                                  :start => Date.new(2015,6,15),
                                  :end => Date.new(2015,6,19)
                          },
                          3 => {
                                  :start => Date.new(2015,6,22),
                                  :end => Date.new(2015,6,26)
                          },
                          4 => {
                                  :start => Date.new(2015,7,13),
                                  :end => Date.new(2015,7,17)
                          },
                          5 => {
                                  :start => Date.new(2015,7,20),
                                  :end => Date.new(2015,7,24)
                          },
                          6 => {
                                  :start => Date.new(2015,7,21),
                                  :end => Date.new(2015,7,25)
                          },
                          7 => {
                                  :start => Date.new(2015,8,3),
                                  :end => Date.new(2015,8,7)
                          }
  }
  end

  def name
    camp.title + " " + "(Ages: #{camp.age})"
  end

  def confirmation_name
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
    if camp.capacity == 0
      0
    else
      camp.capacity - registrations.count
    end
  end

  def at_capacity?
    open_spots <= 0 ? true : false
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      camp_offering = find_by_id(row["id"]) || new
      camp_offering.attributes = row.to_hash.slice(*accessible_attributes)
      camp_offering.save!
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |camp_offering|
        csv << camp_offering.attributes.values_at(*column_names)
      end
    end
  end
end
