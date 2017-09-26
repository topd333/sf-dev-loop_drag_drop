class CampaignsController < ApplicationController
  include FlashMessages
  include AuthenticateUser
  include LogMessages

  before_action :logged_in_user, except: :getdata
  before_action :allowed_player, only: :getdata

  before_action :set_campaign, only: [:show, :edit, :update, :destroy, :getdata, :exception_form]
  before_action :check_campaign_ownership, only: [:show, :edit, :update, :destroy]
  before_action :check_campaign_ownership_api, only: :getdata
  before_action :setup_exception_data, only: [:edit, :exception_form]

  # GET /campaigns
  def index
    @campaigns = current_user.organization.campaigns
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
    if request.xhr?
      render :new_xhr, layout: false
    end
  end

  # GET /campaigns/1
  def show
    redirect_to edit_campaign_path(@campaign)
  end

  # GET /campaigns/1/edit
  def edit

  end

  # POST /campaigns
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.organization = current_user.organization

    if @campaign.save
      log("created the campaign #{@campaign.displayname}", @campaign)
      redirect_to edit_campaign_path(@campaign), notice: 'Campaign was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        log("edited the campaign #{@campaign.displayname}", @campaign)
        format.html { redirect_to campaigns_url, notice: 'Campaign was successfully updated.' }
        format.js { render js: "window.location.href = '#{campaigns_path}';" }
      else
        format.html { render :edit }
        format.js { render js: "SFMain.notify('There are errors in the form. <br/> Please fill out all fields for each exception.', 'danger');" }
        # format.js { render js: "alert('error');" }
        #TODO better javascript for sending error messages
      end
    end
  end

  # DELETE /campaigns/1
  #TODO check if player is using this campaign
  def destroy
    if @campaign.destroy
      log("deleted the campaign #{@campaign.displayname}", @campaign)
      redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
    else
      redirect_to campaigns_url, alert: 'Cannot delete campaign as it is in assigned to at least one player.'
    end
  end

  # GET /campaigns/1/getdata.json
  def getdata
  end

  def exception_form
    if request.xhr?
      render :exception_form, layout: false
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def setup_exception_data
      @hooks_json = @campaign.loop_campaign_hooks.to_json(:only => [:id, :loop_asset_id, :play_info, :start_year, :start_month, :start_day, :start_hour, :start_minute, :start_second, :end_year, :end_month, :end_day, :end_hour, :end_minute, :end_second, :repeat_info])
      @available_loops_json = @current_user.organization.loop_assets.to_json(:only => [:id, :displayname]);
      @loop_assets = @current_user.organization.loop_assets
      @main_loop_asset_id = @campaign.loop_campaign_hooks.where(play_info: 'main').first.try(:loop_asset_id)
      logger.debug(p @hooks_json)
    end

    def check_campaign_ownership
      redirect_to(campaigns_url) unless current_user.organization == @campaign.organization
    end

    def check_campaign_ownership_api
      if Player.find(params[:player_id]).organization != @campaign.organization
        render nothing: true, status: :unauthorized
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:displayname, :hooks_json_string)
    end
end
