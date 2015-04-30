class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user != current_user
      flash[:notice] = "You can't edit another user."
      redirect_to @user
    else
      @user.update(:description => params[:user][:description])
      redirect_to @user
    end
  end
end
