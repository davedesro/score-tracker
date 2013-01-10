require 'spec_helper'

describe Team do

  it { should respond_to :user1_id }
  it { should respond_to :user2_id }
  it { should respond_to :name }
  it { should respond_to :player1 }
  it { should respond_to :player2 }

  describe 'validations' do

    it "should require user1" do
      Team.new.should have(1).error_on :user1_id
    end

    it "should require user2" do
      Team.new.should have(1).error_on :user2_id
    end
  end

  it "should have a user" do
    player1 = FactoryGirl.create(:user)
    player2 = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team, player1: player1, player2: player2)

    team.player1.should == player1
    team.player2.should == player2
  end
end
