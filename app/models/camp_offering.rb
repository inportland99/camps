class CampOffering < ActiveRecord::Base

  has_and_belongs_to_many :registrations
  belongs_to :location
  belongs_to :camp

  CURRENT_YEAR = 4

  YEARS = %w(2014 2015 2016 2017 2018 2019 2020) # year 0 is 2014

  OFFERING_TIMES = ["All Day","AM","PM"]

  if Rails.env.development?
    OFFERING_WEEKS = {
                            1 => {
                                    :start => Date.new(2018,6,4),
                                    :end => Date.new(2018,6,8)
                            },
                            2 => {
                                    :start => Date.new(2018,6,11),
                                    :end => Date.new(2018,6,15)
                            },
                            3 => {
                                    :start => Date.new(2018,6,18),
                                    :end => Date.new(2018,6,22)
                            },
                            4 => {
                                    :start => Date.new(2018,6,25),
                                    :end => Date.new(2018,6,29)
                            },
                            5 => {
                                    :start => Date.new(2018,7,9),
                                    :end => Date.new(2018,7,13)
                            },
                            6 => {
                                    :start => Date.new(2018,7,16),
                                    :end => Date.new(2018,7,20)
                            },
                            7 => {
                                    :start => Date.new(2018,7,23),
                                    :end => Date.new(2018,7,27)
                            },
                            8 => {
                                    :start => Date.new(2018,7,30),
                                    :end => Date.new(2018,8,3)
                            },
                            # 9 => {
                            #         :start => Date.new(2018,8,6),
                            #         :end => Date.new(2018,8,10)
                            # }
    }
  elsif Rails.env.production?
    OFFERING_WEEKS = {
      1 => {
              :start => Date.new(2018,6,4),
              :end => Date.new(2018,6,8)
      },
      2 => {
              :start => Date.new(2018,6,11),
              :end => Date.new(2018,6,15)
      },
      3 => {
              :start => Date.new(2018,6,18),
              :end => Date.new(2018,6,22)
      },
      4 => {
              :start => Date.new(2018,6,25),
              :end => Date.new(2018,6,29)
      },
      5 => {
              :start => Date.new(2018,7,9),
              :end => Date.new(2018,7,13)
      },
      6 => {
              :start => Date.new(2018,7,16),
              :end => Date.new(2018,7,20)
      },
      7 => {
              :start => Date.new(2018,7,23),
              :end => Date.new(2018,7,27)
      },
      8 => {
              :start => Date.new(2018,7,30),
              :end => Date.new(2018,8,3)
      },
      # 9 => {
      #         :start => Date.new(2018,8,6),
      #         :end => Date.new(2018,8,10)
      # }
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

  def select_name
    camp.title + ": " + location.name + ", " + time + " (Start Date: #{start_date.strftime('%b, %d')})"
  end

  def confirmation_name
    camp.title + ": " + location.name + ", " + convert_time + " (Start Date: #{start_date.strftime('%b, %d')})"
  end

  def edit_name
    camp.title + " " + location.name + " Week: " + week.to_s + " " + time
  end

  def convert_time
    case time
      when "AM" then "9:00AM - 12:00PM"
      when "PM" then "12:30PM - 3:30PM"
      when "All Day" then "9:00AM - 3:30PM"
    end
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
