require 'spec_helper'

describe "camp_surveys/show" do
  before(:each) do
    @camp_survey = assign(:camp_survey, stub_model(CampSurvey,
      :staisfaction => 1,
      :comment => "MyText",
      :improvements => "MyText",
      :parent_first_name => "Parent First Name",
      :parent_last_name => "Parent Last Name",
      :student_name => "Student Name",
      :grade_completed => "Grade Completed",
      :phone => "Phone",
      :email => "Email",
      :preferred_contact => "Preferred Contact",
      :contact_fall => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Parent First Name/)
    rendered.should match(/Parent Last Name/)
    rendered.should match(/Student Name/)
    rendered.should match(/Grade Completed/)
    rendered.should match(/Phone/)
    rendered.should match(/Email/)
    rendered.should match(/Preferred Contact/)
    rendered.should match(/false/)
  end
end
