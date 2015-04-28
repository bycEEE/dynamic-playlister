class StaticPagesController < ApplicationController
  def index
    if current_user
      render 'logged_in'
    else
      render 'logged_out'
    end
  end
end
