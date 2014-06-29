require 'spec_helper'

describe "camp_surveys/index" do
  before(:each) do
    assign(:camp_surveys, [
      stub_model(CampSurvey,
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
      ),
      stub_model(CampSurvey,
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
      )
    ])
  end

  it "renders a list of camp_surveys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Parent First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Student Name".to_s, :count => 2
    assert_select "tr>td", :text => "Grade Completed".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Preferred Contact".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
