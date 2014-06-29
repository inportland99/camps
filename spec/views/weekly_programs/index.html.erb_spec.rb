require 'spec_helper'

describe "weekly_programs/index" do
  before(:each) do
    assign(:weekly_programs, [
      stub_model(WeeklyProgram,
        :name => "Name"
      ),
      stub_model(WeeklyProgram,
        :name => "Name"
      )
    ])
  end

  it "renders a list of weekly_programs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
