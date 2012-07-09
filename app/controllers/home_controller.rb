class HomeController < ApplicationController
  def index
   @games = Game.find :all, :conditions => {:status_cd => Game.Active}
   @pending = Game.find :all, :conditions => {:status_cd => Game.Pending}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end
end