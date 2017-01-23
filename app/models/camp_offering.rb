class CampOffering < ActiveRecord::Base

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  CURRENT_YEAR = 3

  YEARS = %w(2014 2015 2016 2017 2018 2019 2020) # year 0 is 2014

  OFFERING_TIMES = ["All Day","AM","PM"]

  if Rails.env.development?
    OFFERING_WEEKS = {
                            1 => {
                                    :start => Date.new(2017,6,5),
                                    :end => Date.new(2017,6,9)
                            },
                            2 => {
                                    :start => Date.new(2017,6,12),
                                    :end => Date.new(2017,6,16)
                            },
                            3 => {
                                    :start => Date.new(2017,6,19),
                                    :end => Date.new(2017,6,23)
                            },
                            4 => {
                                    :start => Date.new(2017,6,26),
                                    :end => Date.new(2017,6,30)
                            },
                            5 => {
                                    :start => Date.new(2017,7,10),
                                    :end => Date.new(2017,7,14)
                            },
                            6 => {
                                    :start => Date.new(2017,7,17),
                                    :end => Date.new(2017,7,21)
                            },
                            7 => {
                                    :start => Date.new(2017,7,24),
                                    :end => Date.new(2017,7,28)
                            },
                            8 => {
                                    :start => Date.new(2017,7,31),
                                    :end => Date.new(2017,8,4)
                            },
                            9 => {
                                    :start => Date.new(2017,8,7),
                                    :end => Date.new(2017,8,11)
                            }
    }
  elsif Rails.env.production?
    OFFERING_WEEKS = {
                            1 => {
                                    :start => Date.new(2017,6,5),
                                    :end => Date.new(2017,6,9)
                            },
                            2 => {
                                    :start => Date.new(2017,6,12),
                                    :end => Date.new(2017,6,16)
                            },
                            3 => {
                                    :start => Date.new(2017,6,19),
                                    :end => Date.new(2017,6,23)
                            },
                            4 => {
                                    :start => Date.new(2017,6,26),
                                    :end => Date.new(2017,6,30)
                            },
                            5 => {
                                    :start => Date.new(2017,7,10),
                                    :end => Date.new(2017,7,14)
                            },
                            6 => {
                                    :start => Date.new(2017,7,17),
                                    :end => Date.new(2017,7,21)
                            },
                            7 => {
                                    :start => Date.new(2017,7,24),
                                    :end => Date.new(2017,7,28)
                            },
                            8 => {
                                    :start => Date.new(2017,7,31),
                                    :end => Date.new(2017,8,4)
                            },
                            9 => {
                                    :start => Date.new(2017,8,7),
                                    :end => Date.new(2017,8,11)
                            }
    }
  end

  def self.accessible_attributes
   ["assistant", "camp_id", "end_date", 'location_id', "start_date", "teacher", "classroom", "time", "week", "hidden", "year", "extended_care"]
  end

  def name
    if camp
      camp.title + " " + "(Ages: #{camp.age})"
    end
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
      camp_offering.attributes = row.to_hash.slice(*accessible_attributes)
      begin
        camp_offering.save!
      rescue ActiveRecord::RecordInvalid => e
        false
      end
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
