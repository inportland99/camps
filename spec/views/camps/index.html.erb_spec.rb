require 'spec_helper'

describe "camps/index" do
  before(:each) do
    assign(:camps, [
      stub_model(Camp,
        :title => "Title",
        :description => "MyText",
        :capacity => 1,
        :age => "Age"
      ),
      stub_model(Camp,
        :title => "Title",
        :description => "MyText",
        :capacity => 1,
        :age => "Age"
      )
    ])
  end

  it "renders a list of camps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Age".to_s, :count => 2
  end
end
