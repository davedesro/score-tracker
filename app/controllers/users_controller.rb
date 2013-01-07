class UsersController < ApplicationController

  before_filter :signed_in_user, only: :edit

  def new
    @user = User.new
  end

  def create
    params[:user][:first_name] = params[:user][:name] if params[:user].present?
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Score Tracker!"
      redirect_to :root
    else
      render :new, status: 400
    end
  end

  def edit
  end
end
