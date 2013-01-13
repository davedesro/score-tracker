class TeamsController < ApplicationController

  before_filter :signed_in_user, except: [ :show ]

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      flash[:success] = "Your team has been created."
      redirect_to team_path(@team)
    else
      render :new
    end
  end

  def show
    @team = Team.find(params[:id])
  end
end
