require 'spec_helper'

describe "Team Pages" do

  before { integration_login }

  describe "structure" do

    subject { page.body }

    describe "New Team" do

      before { visit new_team_path }

      it { should have_selector('title', text: "New Team") }
    end

    describe "Show Team" do

      let(:team) { FactoryGirl.create(:team, name: "Cool Team") }

      before { visit team_path(team) }

      it { should have_selector('title', text: team.name) }
    end
  end

  describe "successful team creation" do

    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
    end

    it "should display the successful flash message" do
      visit new_team_path
      fill_in "First Player's Email",  with: @user1.email
      fill_in "Second Player's Email", with: @user2.email
      click_button "Create Team"
      page.body.should have_selector('.alert.alert-success')
    end
  end

  describe "unsucessful team creation" do

    it "should display the error fields" do
      visit new_team_path
      click_button "Create Team"
      page.body.should have_selector('.alert.alert-error')
      page.body.should have_selector('.field_with_errors')
    end

    it "should not display the email error" do
      visit new_team_path
      click_button "Create Team"
      page.body.should have_selector('.text-error', count: 2)
    end
  end
end

