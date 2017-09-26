class MediaAssetsController < ApplicationController
  include FlashMessages
  include AuthenticateUser
  include LogMessages

  before_action :logged_in_user
  before_action :set_media_asset, only: [:show, :edit, :update, :destroy]

  # GET /media_assets
  def index
    @media_assets = current_user.organization.media_assets
    @image_assets_count = @media_assets.where("asset_file_content_type LIKE 'image%'").count
    @video_assets_count = @media_assets.where("asset_file_content_type LIKE 'video%'").count
  end

  def library
    @media_assets = current_user.organization.media_assets
    @image_assets_count = @media_assets.where("asset_file_content_type LIKE 'image%'").count
    @video_assets_count = @media_assets.where("asset_file_content_type LIKE 'video%'").count
    render :library, layout: false
  end

  # GET /media_assets/1
  def show
    # for accessing json data
    respond_to do |format|
      format.html { redirect_to media_assets_path }
      format.json do
        render json: @media_asset.to_json(methods: [:thumbnail_url, :asset_icon_type, :media_type, :duration_formatted])
      end
    end
  end

  # GET /media_assets/new
  def new
    @media_asset = MediaAsset.new
  end

  # GET /media_assets/1/edit
  def edit
  end

  # POST /media_assets
  def create

    if request.xhr?
      uploaded_io = params[:asset_file]
      @media_asset = MediaAsset.new(asset_file: uploaded_io, displayname: uploaded_io.original_filename)
      @media_asset.organization = current_user.organization
      if @media_asset.save
        log("uploaded media asset #{@media_asset.displayname}", @media_asset)
        render :new_xhr, layout: false
      else
        render plain: @media_asset.errors.full_messages[0], status: 400
        #render nothing: true, status: 400
      end
    else
      @media_asset = MediaAsset.new(media_asset_params)
      @media_asset.organization = current_user.organization
      if @media_asset.save
        log("uploaded media asset #{@media_asset.displayname}", @media_asset)
        redirect_to media_assets_path, notice: 'Media asset was successfully created.'
      else
        render :new
      end
    end

  end

  # PATCH/PUT /media_assets/1
  def update
    if @media_asset.update(media_asset_params)
      log("edited media asset #{@media_asset.displayname}", @media_asset)
      redirect_to media_assets_path, notice: 'Media asset was successfully updated.'
    else
      render :edit
    end
  end

  def update_title
    media_asset = MediaAsset.find(params[:pk])
    previous_displayname = media_asset.displayname
    media_asset.displayname = params[:value]
    if media_asset.save
      log("renamed media asset from #{previous_displayname} to #{media_asset.displayname}", media_asset)
      render plain: {success: true}.to_json, status: 200
    else
      render plain: {success: false, msg: "server error"}.to_json, status: 400
    end
  end

  def destroy
    @media_asset = MediaAsset.find(params[:id])
    @media_asset.destroy
    log("deleted media asset #{@media_asset.displayname}", @media_asset)

    respond_to do |format|
      format.html { redirect_to media_assets_path, notice: 'Media asset was successfully deleted.' }
      format.js
    end
  end

  # DELETE /media_assets/destroy_multiple.js
  def destroy_multiple
    assets = MediaAsset.where(id: params[:media_assets]).where(organization: current_user.organization)
    @ajax_successes = Array.new
    @ajax_errors = Array.new
    @destroy_multiple_successes = Array.new
    assets.each { |to_destroy|
      if to_destroy.destroy
        log("deleted media asset #{to_destroy.displayname}", to_destroy)
        @destroy_multiple_successes << to_destroy.id
        @ajax_successes << "Successfully deleted #{to_destroy.displayname}."
      else
        @ajax_errors.concat(to_destroy.errors.full_messages)
      end
    }
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_media_asset
      @media_asset = MediaAsset.find(params[:id])
      redirect_to(media_assets_url) unless current_user.organization == @media_asset.organization
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_asset_params
      params.require(:media_asset).permit(:asset_file, :displayname)
    end

    # Before Filters
end
