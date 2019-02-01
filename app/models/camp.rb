class Camp < ActiveRecord::Base

  has_many :camp_offerings
  has_many :camp_surveys


  def self.activecamps
    self.find [8,10,12,19,33,4,5,2,32,31,3,9,41,11,37,38,18,7,20,39,42,43]
  end

  def self.accessible_attributes
   ["age", "capacity", "description", "price", "title", "show_description"]
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
