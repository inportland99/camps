require 'spec_helper'

describe "camp_interests/index" do
  before(:each) do
    assign(:camp_interests, [
      stub_model(CampInterest,
        :name => "Name",
        :email => "Email",
        :year => 1,
        :newsletter => false
      ),
      stub_model(CampInterest,
        :name => "Name",
        :email => "Email",
        :year => 1,
        :newsletter => false
      )
    ])
  end

  it "renders a list of camp_interests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
