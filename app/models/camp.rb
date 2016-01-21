class Camp < ActiveRecord::Base

  has_many :camp_offerings
  has_many :camp_surveys



  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      camp = find_by_id(row["id"]) || new
      camp.attributes = row.to_hash.slice(attribute_names)
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
