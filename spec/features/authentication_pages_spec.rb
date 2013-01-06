require 'spec_helper'

describe "Authentication" do

  let(:signin) { "Log Me In" }

  subject { page.body }

  describe "signin page" do

    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign In') }
    it { should have_selector('title', text: 'Sign In') }
  end

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do

      before { click_button signin }

      it { should have_selector 'title', text: "Sign In" }
      it { should have_selector('.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do

        before { click_link "Home" }

        it { should_not have_selector('.alert.alert-error') }
      end
    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Name",     with: user.name
        fill_in "Password", with: user.password
        click_button signin
      end

      it { should have_link(user.name.capitalize,     href: users_path(user))        }
      it { should have_link('Settings',    href: edit_user_path)   }
      it { should have_link('Sign out',    href: signout_path)     }
      it { should_not have_link('Sign in', href: signin_path)      }

      it "should redirect to root page" do
        page.current_url.should == root_url
      end

      describe "followed by signout" do

        before { click_link "Sign out" }

        it "should redirect to root page" do
          page.current_url.should == root_url
        end

        it { should have_link("Sign in") }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do

      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do

        before do
          visit edit_user_path
          fill_in "Name",     with: user.name
          fill_in "Password", with: user.password
          click_button signin
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.current_url.should == edit_user_url
            page.body.should have_selector('title', text: 'Edit User')
          end
        end
      end
    end
  end
end
