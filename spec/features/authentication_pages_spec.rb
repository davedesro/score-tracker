require 'spec_helper'

describe "Authentication" do

  subject { page.body }

  before { integration_login }

  describe "signin with valid information" do

    before do
      @user = User.find_by_first_name('Fixture First Name')
    end

    it { should have_link('Fixture first name', href: '#')  }
    it { should have_link('Profile',            href: user_path(@user)) }
    it { should have_link('Settings',           href: edit_user_path)   }
    it { should have_link('Sign out',           href: signout_path)     }
    it { should have_link('New Team',           href: new_team_path)    }
    it { should_not have_link('Sign in') }

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

  describe "authorization" do

    describe "for non-signed-in users" do

      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do

        before do
          visit edit_user_url
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
