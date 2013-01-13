require 'spec_helper'

describe Team do

  it { should respond_to :user1_id }
  it { should respond_to :user2_id }
  it { should respond_to :user1_email }
  it { should respond_to :user2_email }
  it { should respond_to :name }
  it { should respond_to :player1 }
  it { should respond_to :player2 }

  describe 'validations' do

    it "should require user1 if an email doesn't exist" do
      Team.new.should have(1).error_on :user1_id
    end

    it "should require user2 id if an email doesn't exist" do
      Team.new.should have(1).error_on :user2_id
    end

    it "should not allow user ids to be mass assigned" do
      expect do
        Team.create(user1_id: "1")
      end.to raise_error ActiveModel::MassAssignmentSecurity::Error

      expect do
        Team.create(user2_id: "1")
      end.to raise_error ActiveModel::MassAssignmentSecurity::Error
    end
  end

  it "should have a user" do
    player1 = FactoryGirl.create(:user)
    player2 = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, player1: player1, player2: player2)

    team.player1.should == player1
    team.player2.should == player2
  end

  it "should have a default team name if one doesn't exist" do
    team = FactoryGirl.create(:team, name: '')
    team.name.should == "Boring Team Name #{team.id}"
  end

  it "should set the players by their email" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    team = Team.create(user1_email: user1.email, user2_email: user2.email)
    team.user1_id.should == user1.id
    team.user2_id.should == user2.id
  end
end
