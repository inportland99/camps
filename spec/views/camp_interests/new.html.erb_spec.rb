require 'spec_helper'

describe "camp_interests/new" do
  before(:each) do
    assign(:camp_interest, stub_model(CampInterest,
      :name => "MyString",
      :email => "MyString",
      :year => 1,
      :newsletter => false
    ).as_new_record)
  end

  it "renders new camp_interest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camp_interests_path, "post" do
      assert_select "input#camp_interest_name[name=?]", "camp_interest[name]"
      assert_select "input#camp_interest_email[name=?]", "camp_interest[email]"
      assert_select "input#camp_interest_year[name=?]", "camp_interest[year]"
      assert_select "input#camp_interest_newsletter[name=?]", "camp_interest[newsletter]"
    end
  end
end
