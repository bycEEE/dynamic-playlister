class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(:description => params[:user][:description])
    redirect_to @user
  end
end
