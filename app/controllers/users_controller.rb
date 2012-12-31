class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    if user.save
      head :created
    else
      head :bad_request
    end
  end
end
