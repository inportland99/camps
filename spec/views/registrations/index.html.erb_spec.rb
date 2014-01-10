require 'spec_helper'

describe "registrations/index" do
  before(:each) do
    assign(:registrations, [
      stub_model(Registration,
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
      ),
      stub_model(Registration,
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
      )
    ])
  end

  it "renders a list of registrations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Parent First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Address 1".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Address 2".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Email".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Student First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Student Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Student Grade".to_s, :count => 2
    assert_select "tr>td", :text => "Student Allergies".to_s, :count => 2
    assert_select "tr>td", :text => "Emergency Contact Name".to_s, :count => 2
    assert_select "tr>td", :text => "Emergency Contact Phone".to_s, :count => 2
  end
end
