require 'spec_helper'

describe SessionsController do

  describe "DELETE 'destroy'" do

    it "should sign out the user" do
      subject.should_receive(:sign_out).once
      delete :destroy
      response.should redirect_to root_path
    end
  end
end

