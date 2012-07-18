class PlayersController < ApplicationController
  before_filter :require_login
  before_filter :player_owner, :only => [:edit, :update]
  # GET /players
  # GET /players.json
  def index
    @players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])
    @user = @player.user
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end
=begin
  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end
  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateAdmin
    @player = Player.find(params[:id])
    @user = @player.user
    if !current_user.admin then return redirect_to @player, notice: 'Admin status not changed' end
    respond_to do |format|
    if @user.update_attributes(params[:user])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @player, notice: 'Admin status not changed' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end
=begin
  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
=end
  def player_owner()
    @player = Player.find(params[:id])
    if @player.id != current_user.player.id
      flash[:notice] = "Not allowed to modify others' profiles"
      redirect_to root_url
    end
  end
end
