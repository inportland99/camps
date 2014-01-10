require 'spec_helper'

describe "camp_offerings/new" do
  before(:each) do
    assign(:camp_offering, stub_model(CampOffering,
      :camp_id => 1,
      :teacher => "MyString",
      :assistant => "MyString",
      :location_id => 1
    ).as_new_record)
  end

  it "renders new camp_offering form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camp_offerings_path, "post" do
      assert_select "input#camp_offering_camp_id[name=?]", "camp_offering[camp_id]"
      assert_select "input#camp_offering_teacher[name=?]", "camp_offering[teacher]"
      assert_select "input#camp_offering_assistant[name=?]", "camp_offering[assistant]"
      assert_select "input#camp_offering_location_id[name=?]", "camp_offering[location_id]"
    end
  end
end
