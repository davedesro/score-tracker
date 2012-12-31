require 'spec_helper'

describe "User Pages" do

  subject { page.body }

  describe "Sign Up Page" do

    before { visit new_user_path }

    it { should have_selector 'title', text: title('Sign Up') }
  end
end

