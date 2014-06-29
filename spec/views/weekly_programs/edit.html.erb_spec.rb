require 'spec_helper'

describe "weekly_programs/edit" do
  before(:each) do
    @weekly_program = assign(:weekly_program, stub_model(WeeklyProgram,
      :name => "MyString"
    ))
  end

  it "renders the edit weekly_program form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", weekly_program_path(@weekly_program), "post" do
      assert_select "input#weekly_program_name[name=?]", "weekly_program[name]"
    end
  end
end
