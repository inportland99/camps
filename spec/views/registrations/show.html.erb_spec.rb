require 'spec_helper'

describe "registrations/show" do
  before(:each) do
    @registration = assign(:registration, stub_model(Registration,
      :parent_first_name => "Parent First Name",
      :parent_last_name => "Parent Last Name",
      :parent_address_1 => "Parent Address 1",
      :parent_address_2 => "Parent Address 2",
      :parent_email => "Parent Email",
      :parent_phone => "Parent Phone",
      :student_first_name => "Student First Name",
      :student_last_name => "Student Last Name",
      :student_grade => "Student Grade",
      :student_allergies => "Student Allergies",
      :emergency_contact_name => "Emergency Contact Name",
      :emergency_contact_phone => "Emergency Contact Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Parent First Name/)
    rendered.should match(/Parent Last Name/)
    rendered.should match(/Parent Address 1/)
    rendered.should match(/Parent Address 2/)
    rendered.should match(/Parent Email/)
    rendered.should match(/Parent Phone/)
    rendered.should match(/Student First Name/)
    rendered.should match(/Student Last Name/)
    rendered.should match(/Student Grade/)
    rendered.should match(/Student Allergies/)
    rendered.should match(/Emergency Contact Name/)
    rendered.should match(/Emergency Contact Phone/)
  end
end
