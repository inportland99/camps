namespace :infusionsoft do
  desc "Send Confirmation for Summer Camps."
  task tasks: :environment do
    find_and_add_parent_infusion_id
  end
end


def find_and_add_parent_infusion_id
  registrations = Registration.where(year: CampOffering::CURRENT_YEAR)

  registrations.each do |registration|
    result = Infusionsoft.contact_find_by_email(registration.parent_email, [:Id])
    if !result.empty?
      if registration.update_attribute :infusionsoft_id, result.first["Id"].to_i
        puts "Infusionsoft ID added for #{registration.parent_email}"
      end
    end
  end
end
