# ADMIN 
class Admin::PlayersController < ApplicationController
  include FlashMessages
  include AuthenticateUser

  before_action :logged_in_user, except: [:getdata, :getfiles]
  before_action :soadmin_user

  before_action :set_player, only: [:show, :edit, :update, :destroy, :resetconnection]

  # GET /players
  def index
    allplayers = Player.all
    @players = allplayers.where(activated: true)
    @pendingplayers = allplayers.where(activated: false);
  end

  # GET /players/1
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
    @player.organization_id = params[:orgid]
    @player.name = "New Player"
    @player.description = "No description set"
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  def create
    @player = Player.new(new_player_params)
    @player.activated = false
    @player.access_code = SecureRandom.hex(4)

    if @player.save
      redirect_to [:admin, @player], notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(edit_player_params)
      redirect_to admin_players_url, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
    redirect_to admin_players_url, notice: 'Player was successfully destroyed.'
  end

  # POST /players/1/resetconnection
  def resetconnection
    @player.activated = false
    @player.uniqkey = nil
    if @player.save
      redirect_to [:admin, @player], notice: 'Secret access key reset. Please reconnect player to complete.'
    else
      redirect_to [:admin, @player], alert: "Couldn't reset the connection code."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_player_params
      params.require(:player).permit(:name, :description, :serial_number, :organization_id, :admin_pay_program_id, :admin_hardware_type_id)
    end
    def edit_player_params
      params.require(:player).permit(:name, :description)
    end
end
