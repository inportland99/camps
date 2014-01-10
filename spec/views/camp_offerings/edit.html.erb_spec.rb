require 'spec_helper'

describe "camp_offerings/edit" do
  before(:each) do
    @camp_offering = assign(:camp_offering, stub_model(CampOffering,
      :camp_id => 1,
      :teacher => "MyString",
      :assistant => "MyString",
      :location_id => 1
    ))
  end

  it "renders the edit camp_offering form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", camp_offering_path(@camp_offering), "post" do
      assert_select "input#camp_offering_camp_id[name=?]", "camp_offering[camp_id]"
      assert_select "input#camp_offering_teacher[name=?]", "camp_offering[teacher]"
      assert_select "input#camp_offering_assistant[name=?]", "camp_offering[assistant]"
      assert_select "input#camp_offering_location_id[name=?]", "camp_offering[location_id]"
    end
  end
end
