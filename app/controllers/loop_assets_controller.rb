class LoopAssetsController < ApplicationController
  include FlashMessages
  include AuthenticateUser
  include LogMessages

  before_action :logged_in_user, except: :getdata
  before_action :allowed_player, only: :getdata

  before_action :set_loop_asset, only: [:show, :edit, :update, :destroy, :getdata]
  before_action :check_loop_ownership, only: [:show, :edit, :update, :destroy]
  before_action :check_loop_ownership_api, only: :getdata

  skip_before_action :verify_authenticity_token, if: :js_request?

  # GET /loop_assets
  def index
    @loop_assets = current_user.organization.loop_assets.all
    @new_loop_asset = current_user.organization.loop_assets.build
  end

  # GET /loop_assets/1
  def show
    redirect_to edit_loop_asset_path(@loop_asset)
  end

  # GET /loop_assets/1/getdata.json
  def getdata
  end

  # GET /loop_assets/new
  def new
    @loop_asset = current_user.organization.loop_assets.build
    #TODO include organization owned templates as well
    @slide_templates = SlideTemplate.where(organization: nil)
    @media_assets = current_user.organization.media_assets
    if request.xhr?
      render :new_xhr, layout: false
    end
  end


  # GET /loop_assets/1/edit
  def edit
    @media_assets = current_user.organization.media_assets
    @image_assets_count = @media_assets.where("asset_file_content_type LIKE 'image%'").count
    @video_assets_count = @media_assets.where("asset_file_content_type LIKE 'video%'").count
  end

  # POST /loop_assets
  def create
    @loop_asset = current_user.organization.loop_assets.build(loop_asset_params)

    respond_to do |format|
      format.html do
        if @loop_asset.save
          log("created the loop #{@loop_asset.displayname}", @loop_asset)
          redirect_to edit_loop_asset_path(@loop_asset)
        else
          render :new
        end
      end
      format.js do
        if @loop_asset.save
          log("created the loop #{@loop_asset.displayname}", @loop_asset)
          render :new
          # redirect_to edit_loop_asset_path(@loop_asset), notice: 'Loop was successfully created.'
        else

        end
      end
    end

  end

  # PATCH/PUT /loop_assets/1
  def update
    respond_to do |format|
      if @loop_asset.update(loop_asset_params)
        log("edited the loop #{@loop_asset.displayname}", @loop_asset)
        # format.html { redirect_to edit_loop_asset_path(@loop_asset), notice: 'Loop asset was successfully updated.' }
        format.html { redirect_to loop_assets_path, notice: 'Loop asset was successfully updated.' }
        format.js { render js: "disableSave(); alert('success');" }
      else
        # format.html { redirect_to edit_loop_asset_path(@loop_asset), notice: @loop_asset.errors.full_messages }
        format.html { redirect_to loop_assets_path, notice: @loop_asset.errors.full_messages }
        format.js { render js: "SFMain.nofity('"+ @loop_asset.errors.full_messages[0] +"'', 'danger'); console.log('" + @loop_asset.errors.full_messages[0] + "');" }
        #TODO make this better. This is just an example of how to get data to javascript
      end
    end
  end

  def destroy
    @loop_asset = LoopAsset.find(params[:id])
    @loop_asset.destroy

    respond_to do |format|
      format.html { redirect_to media_assets_path, notice: 'Media asset was successfully created.' }
      format.js
    end
  end

  # DELETE /loop_assets/destroy_multiple.js
  def destroy_multiple
    assets = LoopAsset.where(id: params[:loop_assets]).where(organization: current_user.organization)
    @ajax_errors = Array.new
    @ajax_successes = Array.new
    @destroy_multiple_successes = Array.new
    assets.each { |to_destroy|
      if to_destroy.destroy
        log("deleted the loop #{to_destroy.displayname}", to_destroy)
        @destroy_multiple_successes << to_destroy.id
        @ajax_successes << "Successfully deleted #{to_destroy.displayname}."
      else
        @ajax_errors.concat(to_destroy.errors.full_messages)
      end
    }
  end

  private

    def js_request?
      request.format.js?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_loop_asset
      @loop_asset = LoopAsset.find(params[:id])
    end

    def check_loop_ownership
      redirect_to(loop_assets_url) unless current_user.organization == @loop_asset.organization
    end

    def check_loop_ownership_api
      if Player.find(params[:player_id]).organization != @loop_asset.organization
        render nothing: true, status: :unauthorized
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loop_asset_params
      params.require(:loop_asset).permit(:displayname, :loop_json_string)
    end
end
