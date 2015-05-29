class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    render 'new'
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end


end
