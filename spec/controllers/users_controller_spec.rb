require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do

    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do

    describe "with proper input" do

      it "returns http created" do
        post :create, user: { employee_id: "1", name: "Bob", tagline: "best. player. ever." }
        response.status.should == 201
      end

      it "should create a user" do
        expect do
          post :create, user: { employee_id: "1", name: "Bob", tagline: "best. player. ever." }
        end.to change(User, :count).by 1
      end

      it "should properly set the user attributes" do
        post :create, user: { employee_id: "1", name: "Bob", tagline: "best. player. ever." }
        new_user = User.first
        new_user.employee_id = 1
        new_user.name        = "Bob"
        new_user.tagline     = "best. player. ever."
      end
    end

    describe "with bad input" do

      it "returns http error" do
        post :create
        response.status.should == 400
      end
    end
  end
end
