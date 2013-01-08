require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do

    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'edit'" do

    describe "when logged in" do

      before { login }

      it "should be success" do
        get :edit
        response.should be_success
      end
    end

    describe "when not logged in" do

      it "should return unauthorized" do
        get :edit
        response.status.should == 401
      end
    end
  end

  describe "GET 'show'" do

    let(:user) { FactoryGirl.create(:user) }

    it "should be success" do
      get :show, id: user
      response.should be_success
    end
  end
end
