require 'spec_helper'

describe "registrations/new" do
  before(:each) do
    assign(:registration, stub_model(Registration,
      :parent_first_name => "MyString",
      :parent_last_name => "MyString",
      :parent_address_1 => "MyString",
      :parent_address_2 => "MyString",
      :parent_email => "MyString",
      :parent_phone => "MyString",
      :student_first_name => "MyString",
      :student_last_name => "MyString",
      :student_grade => "MyString",
      :student_allergies => "MyString",
      :emergency_contact_name => "MyString",
      :emergency_contact_phone => "MyString"
    ).as_new_record)
  end

  it "renders new registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", registrations_path, "post" do
      assert_select "input#registration_parent_first_name[name=?]", "registration[parent_first_name]"
      assert_select "input#registration_parent_last_name[name=?]", "registration[parent_last_name]"
      assert_select "input#registration_parent_address_1[name=?]", "registration[parent_address_1]"
      assert_select "input#registration_parent_address_2[name=?]", "registration[parent_address_2]"
      assert_select "input#registration_parent_email[name=?]", "registration[parent_email]"
      assert_select "input#registration_parent_phone[name=?]", "registration[parent_phone]"
      assert_select "input#registration_student_first_name[name=?]", "registration[student_first_name]"
      assert_select "input#registration_student_last_name[name=?]", "registration[student_last_name]"
      assert_select "input#registration_student_grade[name=?]", "registration[student_grade]"
      assert_select "input#registration_student_allergies[name=?]", "registration[student_allergies]"
      assert_select "input#registration_emergency_contact_name[name=?]", "registration[emergency_contact_name]"
      assert_select "input#registration_emergency_contact_phone[name=?]", "registration[emergency_contact_phone]"
    end
  end
end
