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

      let(:create_user) do
        post :create, user: {
          employee_id: "1", name: "Bob", first_name: "Bob", tagline: "best. player. ever.",
          password: 'foobar', password_confirmation: 'foobar', email: 'tom@example.com'
        }
      end

      it "returns http created" do
        create_user
        response.should redirect_to root_url
      end

      it "should create a user" do
        expect do
          create_user
        end.to change(User, :count).by 1
      end

      it "should properly set the user attributes" do
        create_user
        new_user = User.first
        new_user.employee_id = 1
        new_user.name        = "Bob"
        new_user.tagline     = "best. player. ever."
      end

      it "should sign in the new user" do
        subject.should_receive(:sign_in).once.with(instance_of User)
        create_user
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
