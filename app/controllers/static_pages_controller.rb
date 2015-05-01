class StaticPagesController < ApplicationController
  skip_before_filter :require_login
  
  def index
    if current_user
      render 'logged_in'
    else
      render 'logged_out'
    end
  end
end
