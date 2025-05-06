class CampOfferingsRegistrationsJoinTable < ActiveRecord::Migration[6.0]
  create_table :camp_offerings_registrations, :id => false do |t|
   t.references :camp_offering, :null => false
   t.references :registration, :null => false
  end

  # Adding the index can massively speed up join tables. Don't use the
  # unique if you allow duplicates.
  add_index(:camp_offerings_registrations, [:camp_offering_id, :registration_id], :unique => true, :name => 'camp_off_reg')
end
