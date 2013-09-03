class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  before_filter :require_login
  before_filter :game_owner, :only => [:edit, :update, :destroy]
  def index
    redirect_to root_url
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @signup = Signup.new
    @signups = Signup.find_all_by_game_id(params[:id])
    @signupsIDs = @signups.map {|x| x.nation_id}
    @signupsByNation = Hash[@signups.map {|x| [x.nation_id, x]}]
    #puts @signupsByNation.inspect
    if @game.version_cd == 3
      @nations = Dom3::ConstData::NATIONS[@game.era.to_s].clone
    else
      @nations = Dom4::ConstData::NATIONS[@game.era.to_s].clone
    end
    @nationIDs = @nations.keys
    @signupsIDs.each {|id| if !@nationIDs.include?(id) then @nationIDs.push(id) end}
    @openNations = @nations.clone.delete_if {|key, value| @signupsIDs.include?(key)}
    if @game.allow_signup?
      view = 'show_signup'
    else
      view = 'show'
    end
    respond_to do |format|
      format.html {render view}
      format.json { render json: @game }
    end

  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
    @game.host_id = current_user.player.id
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
=begin
  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end
=end
  def game_owner()
    @game = Game.find(params[:id])
    if @game.host_id != current_user.id && !current_user.admin
      flash[:notice] = "Not allowed to modify games if you aren't the host or an admin"
      redirect_to @game
    end
  end
end
