require 'spec_helper'

describe "camp_interests/show" do
  before(:each) do
    @camp_interest = assign(:camp_interest, stub_model(CampInterest,
      :name => "Name",
      :email => "Email",
      :year => 1,
      :newsletter => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/false/)
  end
end
