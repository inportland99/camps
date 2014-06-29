require 'spec_helper'

describe "weekly_programs/new" do
  before(:each) do
    assign(:weekly_program, stub_model(WeeklyProgram,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new weekly_program form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", weekly_programs_path, "post" do
      assert_select "input#weekly_program_name[name=?]", "weekly_program[name]"
    end
  end
end
