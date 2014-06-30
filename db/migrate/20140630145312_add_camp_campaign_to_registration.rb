class AddCampCampaignToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :camp_campaign, :boolean, default: false
  end
end
