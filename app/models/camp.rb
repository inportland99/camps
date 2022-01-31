class Camp < ActiveRecord::Base

  has_many :camp_offerings
  has_many :camp_surveys


  def self.activecamps
    self.where("active = ?", true)
  end

  def self.inpersoncamps
    self.where("online = ? AND active = ?", false, true)
  end

  def self.onlinecamps
    self.where("online = ? AND active = ?", true, true)
  end

  def short_name
    self.title.partition(': ').last
  end

  def self.accessible_attributes
   ["age", "capacity", "description", "price", "title", "show_description", "girls_only", "online", "active", "parent_webpage"]
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      camp = find_by_id(row["id"]) || new
      camp.attributes = row.to_hash.slice(*accessible_attributes)
      camp.save!
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |camp|
        csv << camp.attributes.values_at(*column_names)
      end
    end
  end
end
