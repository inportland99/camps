require 'spec_helper'

describe "camps/new" do
  before(:each) do
    assign(:camp, stub_model(Camp,
      :title => "MyString",
      :description => "MyText",
      :capacity => 1,
      :age => "MyString"
    ).as_new_record)
  end

  it "renders new camp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camps_path, "post" do
      assert_select "input#camp_title[name=?]", "camp[title]"
      assert_select "textarea#camp_description[name=?]", "camp[description]"
      assert_select "input#camp_capacity[name=?]", "camp[capacity]"
      assert_select "input#camp_age[name=?]", "camp[age]"
    end
  end
end
