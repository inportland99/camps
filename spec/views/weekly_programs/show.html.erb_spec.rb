require 'spec_helper'

describe "weekly_programs/show" do
  before(:each) do
    @weekly_program = assign(:weekly_program, stub_model(WeeklyProgram,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
