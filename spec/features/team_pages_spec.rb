require 'spec_helper'

describe "Team Pages" do

  describe "structure" do

    subject { page.body }

    before { visit new_team_path }

    it { should have_selector('input.bootstrap-friendly') }
    it { should have_selector('title', text: "New Team")}
  end

  describe "unsucessful team creation" do

    it "should display the error fields" do
      visit new_team_path
      click_button "Create Team"
      page.body.should have_selector('.alert.alert-error')
      page.body.should have_selector('input.error')
    end
  end
end

