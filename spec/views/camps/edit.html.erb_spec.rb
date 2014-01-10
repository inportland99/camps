require 'spec_helper'

describe "camps/edit" do
  before(:each) do
    @camp = assign(:camp, stub_model(Camp,
      :title => "MyString",
      :description => "MyText",
      :capacity => 1,
      :age => "MyString"
    ))
  end

  it "renders the edit camp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camp_path(@camp), "post" do
      assert_select "input#camp_title[name=?]", "camp[title]"
      assert_select "textarea#camp_description[name=?]", "camp[description]"
      assert_select "input#camp_capacity[name=?]", "camp[capacity]"
      assert_select "input#camp_age[name=?]", "camp[age]"
    end
  end
end
