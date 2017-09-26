class PlayersController < ApplicationController
  include FlashMessages
  include AuthenticateUser
  include LogMessages

  before_action :logged_in_user, except: [:getdata, :getfiles]
  before_action :allowed_player, only: [:getdata, :getfiles]

  before_action :set_player, only: [:show, :edit, :update, :getdata, :getfiles, :sendCommand, :activate]
  before_action :check_player_ownership, only: [:show, :edit, :update, :activate, :sendCommand]
  before_action :check_player_ownership_api, only: [:getdata, :getfiles]

  skip_before_filter :verify_authenticity_token, :only => [:getdata]

  # GET /players
  def index
    allplayers = current_user.organization.players
    @players = allplayers.where(activated: true)
    @pendingplayers = allplayers.where(activated: false);
  end

  # GET /players/1
  def show
  end

  # GET /players/1/edit
  def edit
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(edit_player_params)
      log("edited player #{@player.name}", @player)
      redirect_to players_url, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  # This action reports information to the requesting player
  # GET /players/1/getdata.json
  def getdata
    if @player.activated == false
      if !@player.update_attribute(:activated, true) || !@player.update_attribute(:uniqkey, params[:uniqkey])
        render status: 500
        return
      end      
    end
    render :getdata, layout: false
    @player.diagnostics[:lastReboot] = params[:lastReboot]
    @player.diagnostics[:currentCampaign] = params[:currentCampaign]
    @player.diagnostics[:lastUpdateStamp] = params[:lastUpdateStamp]
    @player.pending_action = nil
    @player.save
    @player.touch(:last_connection)
  end

  # This action lists required files to the requesting player
  # GET /players/1/getfiles.json
  def getfiles
    render :getfiles, layout: false
  end

  # This action sends commands to the player
  # POST /players/1/sendCommand?command=restart
  def sendCommand
    if params[:command] == 'restart'
      @player.pending_action = 'reboot'
    elsif params[:command] == 'contentReload'
      @player.pending_action = 'forceReload'
    elsif params[:command] == 'clear'
      @player.pending_action = nil
    else
      redirect_to @player, notice: 'Unsupported command'
      return
    end
    
    if @player.save
      redirect_to @player, notice: 'Command pending'
    else
      redirect_to @player, notice: 'Error sending command'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    def check_player_ownership
      redirect_to(root_url) unless current_user.organization == @player.organization
    end

    def check_player_ownership_api
      if params[:player_id] != @player.id.to_s
        render nothing: true, status: :unauthorized
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edit_player_params
      params.require(:player).permit(:name, :description, :campaign_id)
    end
end
