require 'spec_helper'

describe "camps/show" do
  before(:each) do
    @camp = assign(:camp, stub_model(Camp,
      :title => "Title",
      :description => "MyText",
      :capacity => 1,
      :age => "Age"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Age/)
  end
end
