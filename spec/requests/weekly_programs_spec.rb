require 'spec_helper'

describe "WeeklyPrograms" do
  describe "GET /weekly_programs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get weekly_programs_path
      response.status.should be(200)
    end
  end
end
