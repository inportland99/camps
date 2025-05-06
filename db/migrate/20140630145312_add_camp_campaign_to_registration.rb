class AddCampCampaignToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :camp_campaign, :boolean, default: false
  end
end
