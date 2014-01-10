require 'spec_helper'

describe "camp_offerings/index" do
  before(:each) do
    assign(:camp_offerings, [
      stub_model(CampOffering,
        :camp_id => 1,
        :teacher => "Teacher",
        :assistant => "Assistant",
        :location_id => 2
      ),
      stub_model(CampOffering,
        :camp_id => 1,
        :teacher => "Teacher",
        :assistant => "Assistant",
        :location_id => 2
      )
    ])
  end

  it "renders a list of camp_offerings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Teacher".to_s, :count => 2
    assert_select "tr>td", :text => "Assistant".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
