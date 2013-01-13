require 'spec_helper'

describe TeamsController do

  describe "GET 'new'" do

    describe "logged in user" do

      before { login }

      it "should be success" do
        get :new
        response.should be_success
      end
    end

    describe "unknown user" do

      it "should return unauthorized" do
        get :new
        response.status.should == 401
      end
    end
  end

  describe "POST 'create'" do

    describe "logged in user" do

      before { login }

      describe "sucessfully" do

        let(:create_team) do
          post :create, team: {
            user1_email: FactoryGirl.create(:user).email,
            user2_email: FactoryGirl.create(:user).email,
            name: ""
          }
        end

        it "should create a new team" do
          expect { create_team }.to change(Team, :count).by 1
        end

        it "should redirect to the team homepage" do
          create_team
          response.should redirect_to team_path(Team.all.first)
        end
      end

      describe "unsucessfully" do

        let(:create_team) { post :create }

        it "should not create a new team" do
          expect { create_team }.to_not change(Team, :count).by 1
        end

        it "should rerender the 'new' page" do
          create_team
          response.should render_template :new
        end
      end
    end

    describe "unknown user" do

      let(:create_team) do
        post :create, team: {
          user1_email: FactoryGirl.create(:user).email,
          user2_email: FactoryGirl.create(:user).email,
          name: ""
        }
      end

      it "should return unauthorized" do
        create_team
        response.status.should == 401
      end
    end
  end

  describe "GET 'show'" do

    it "should be success" do
      get :show, id: FactoryGirl.create(:team)
      response.should be_success
    end
  end

end
