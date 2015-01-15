require 'spec_helper'

describe "camp_interests/edit" do
  before(:each) do
    @camp_interest = assign(:camp_interest, stub_model(CampInterest,
      :name => "MyString",
      :email => "MyString",
      :year => 1,
      :newsletter => false
    ))
  end

  it "renders the edit camp_interest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camp_interest_path(@camp_interest), "post" do
      assert_select "input#camp_interest_name[name=?]", "camp_interest[name]"
      assert_select "input#camp_interest_email[name=?]", "camp_interest[email]"
      assert_select "input#camp_interest_year[name=?]", "camp_interest[year]"
      assert_select "input#camp_interest_newsletter[name=?]", "camp_interest[newsletter]"
    end
  end
end
