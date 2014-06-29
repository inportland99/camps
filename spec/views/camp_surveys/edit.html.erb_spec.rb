require 'spec_helper'

describe "camp_surveys/edit" do
  before(:each) do
    @camp_survey = assign(:camp_survey, stub_model(CampSurvey,
      :staisfaction => 1,
      :comment => "MyText",
      :improvements => "MyText",
      :parent_first_name => "MyString",
      :parent_last_name => "MyString",
      :student_name => "MyString",
      :grade_completed => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :preferred_contact => "MyString",
      :contact_fall => false
    ))
  end

  it "renders the edit camp_survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camp_survey_path(@camp_survey), "post" do
      assert_select "input#camp_survey_staisfaction[name=?]", "camp_survey[staisfaction]"
      assert_select "textarea#camp_survey_comment[name=?]", "camp_survey[comment]"
      assert_select "textarea#camp_survey_improvements[name=?]", "camp_survey[improvements]"
      assert_select "input#camp_survey_parent_first_name[name=?]", "camp_survey[parent_first_name]"
      assert_select "input#camp_survey_parent_last_name[name=?]", "camp_survey[parent_last_name]"
      assert_select "input#camp_survey_student_name[name=?]", "camp_survey[student_name]"
      assert_select "input#camp_survey_grade_completed[name=?]", "camp_survey[grade_completed]"
      assert_select "input#camp_survey_phone[name=?]", "camp_survey[phone]"
      assert_select "input#camp_survey_email[name=?]", "camp_survey[email]"
      assert_select "input#camp_survey_preferred_contact[name=?]", "camp_survey[preferred_contact]"
      assert_select "input#camp_survey_contact_fall[name=?]", "camp_survey[contact_fall]"
    end
  end
end
