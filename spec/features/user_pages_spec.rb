require 'spec_helper'

describe "User Pages" do

  subject { page.body }

  let(:signup) { "Create My Account" }

  describe "Sign Up Page" do

    before { visit new_user_path }

    it { should have_selector 'title', text: title('Sign Up') }

    describe "with incorrectly filled form" do

      it "should not add a new user" do
        expect { click_button signup}.not_to change(User, :count)
      end

      it "should display the error message of the field(s)" do
        click_button signup
        page.should have_selector '.field_with_errors'
        page.should have_selector '.help-inline', text: "ID can't be blank"
      end

      it "should let the user know there are errors" do
        click_button signup
        page.should have_selector '.alert'
        page.should have_selector '.alert-error'
      end
    end

    describe "with correctly filled in form" do

      it "should create a new user" do
        fill_in :user_employee_id,           with: "9"
        fill_in :user_name,                  with: "Example User"
        fill_in :user_tagline,               with: "I'm kind of a big deal"
        fill_in :user_password,              with: "foobar"
        fill_in :user_password_confirmation, with: "foobar"
        expect { click_button signup }.to change(User, :count).by 1
      end

      # it "should redirect to home page with flash message" do
      #   fill_in :user_employee_id, with: "9"
      #   fill_in :user_name,        with: "Example User"
      #   fill_in :user_tagline,     with: "I'm kind of a big deal"
      #   click_button "Create My Account"
      #   page.current_url.should == root_url
      # end
    end
  end
end

