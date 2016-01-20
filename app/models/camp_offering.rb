class CampOffering < ActiveRecord::Base

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  YEARS = %w(2014 2015 2016 2017 2018 2019 2020) # year 0 is 2014

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
                                  :start => Date.new(2016,6,6),
                                  :end => Date.new(2016,6,10)
                          },
                          2 => {
                                  :start => Date.new(2016,6,13),
                                  :end => Date.new(2016,6,17)
                          },
                          3 => {
                                  :start => Date.new(2016,6,20),
                                  :end => Date.new(2016,6,24)
                          },
                          4 => {
                                  :start => Date.new(2016,6,27),
                                  :end => Date.new(2016,7,1)
                          },
                          5 => {
                                  :start => Date.new(2016,7,11),
                                  :end => Date.new(2016,7,15)
                          },
                          6 => {
                                  :start => Date.new(2016,7,18),
                                  :end => Date.new(2016,7,22)
                          },
                          7 => {
                                  :start => Date.new(2016,7,25),
                                  :end => Date.new(2016,7,29)
                          },
                          8 => {
                                  :start => Date.new(2016,8,1),
                                  :end => Date.new(2016,8,5)
                          },
                          9 => {
                                  :start => Date.new(2016,8,8),
                                  :end => Date.new(2016,8,12)
                          }
  }
  end

  def name
    camp.title + " " + "(Ages: #{camp.age})"
  end

  def extended_care_name
    camp.title
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

  def self.by_week(location, week, year)
    where("location_id=? AND week=? AND year=?", location, week, year)
  end

  def self.extended_care(location, week, year)
    where("location_id=? AND week=? AND year=? AND extended_care = ?", location, week, year, true)
  end

  def price
    camp.price if camp
  end

  def open_spots
    if camp && camp.capacity < 1
      0
    elsif camp && camp.capacity >= 1
      camp.capacity - registrations.count
    else
      "no capacity"
    end
  end

  def at_capacity?
    if open_spots == "no capacity"
      true
    else
      open_spots <= 0 ? true : false
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      camp_offering = find_by_id(row["id"]) || new
      camp_offering.attributes = row.to_hash.slice(attribute_names)
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
