require 'spec_helper'

describe SessionsController do

  describe "POST 'create'" do

    it "should not log the user in if user doesn't exist" do
      post :create, session: { name: 'dave', password: 'foobar' }
      response.should render_template 'new'
      flash[:error].should_not be_nil
    end

    it "should not log in the user if the password is incorrect" do
      FactoryGirl.create(:user, name: 'dave')
      post :create, session: { name: 'dave', password: 'bad-password' }
      response.should render_template 'new'
      flash[:error].should_not be_nil
    end

    it "should log in the user with good credentials" do
      FactoryGirl.create :user, name: 'dave', password: 'foobarfoobar'
      post :create, session: { name: 'dave', password: 'foobarfoobar' }
      response.should redirect_to root_path
    end
  end
end

