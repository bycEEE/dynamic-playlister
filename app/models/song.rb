class Song < ActiveRecord::Base
  has_many :requests

  def create
  	binding.pry
  end

  def new
  	binding.pry
  end
end
