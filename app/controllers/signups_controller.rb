class SignupsController < ApplicationController
  # GET /signups
  # GET /signups.json
  before_filter :require_login, :only => [:create, :destroy]
  before_filter :signup_owner, :only => [:destroy]
=begin
  def index
    @signups = Signup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @signups }
    end
  end

  # GET /signups/1
  # GET /signups/1.json
  def show
    @signup = Signup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @signup }
    end
  end

  # GET /signups/new
  # GET /signups/new.json
  def new
    @signup = Signup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @signup }
    end
  end

  # GET /signups/1/edit
  def edit
    @signup = Signup.find(params[:id])
  end
=end
  # POST /signups
  # POST /signups.json
  def create
    @signup = Signup.new(params[:signup])

    respond_to do |format|
      if @signup.save
        flash[:notice] = 'Signup was successfully created.'
        format.html { redirect_to :controller => "games", :action => "show", :id => @signup.game_id }
        format.json { render json: @signup, status: :created, location: @signup }
      else
        flash[:notice] = 'Error creating signup.'
        format.html { redirect_to :controller => "games", :action => "show", :id => @signup.game_id }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end
=begin
  # PUT /signups/1
  # PUT /signups/1.json
  def update
    @signup = Signup.find(params[:id])

    respond_to do |format|
      if @signup.update_attributes(params[:signup])
        format.html { redirect_to @signup, notice: 'Signup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    @signup = Signup.find(params[:id])
    @game_id = @signup.game_id
    @signup.destroy

    respond_to do |format|
      flash[:notice] = 'Signup deleted'
      format.html { redirect_to :controller => "games", :action => "show", :id => @game_id}
      format.json { head :no_content }
    end
  end
  def signup_owner()
    @signup = Signup.find(params[:id])
    if @signup.player_id != current_user.player.id && !current_user.admin
      flash[:notice] = "Not allowed to modify others' signups"
      redirect_to root_url
    end
  end
end
