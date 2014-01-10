require 'spec_helper'

describe "camp_offerings/show" do
  before(:each) do
    @camp_offering = assign(:camp_offering, stub_model(CampOffering,
      :camp_id => 1,
      :teacher => "Teacher",
      :assistant => "Assistant",
      :location_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Teacher/)
    rendered.should match(/Assistant/)
    rendered.should match(/2/)
  end
end
