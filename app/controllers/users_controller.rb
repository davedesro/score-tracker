class UsersController < ApplicationController

  before_filter :signed_in_user, only: :edit

  def index
  end

  def edit
  end

  def show
  end
end
