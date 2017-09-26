class SlideAssetsController < ApplicationController
  include FlashMessages
  include AuthenticateUser

  before_action :logged_in_user, except: :htmlsrc
  before_action :allowed_player, only: :htmlsrc

  before_action :set_loop_asset
  before_action :check_loop_asset_ownership, only: [:show, :edit, :update, :destroy]
  before_action :check_loop_asset_ownership_api, only: :htmlsrc

  before_action :set_slide_asset, only: [:show, :edit, :update, :destroy, :htmlsrc, :preview]


  # GET /slide_assets/1
  def show
  end

  # GET /slide_assets/new
  def new
    @slide_asset = SlideAsset.new
  end

  # GET /slide_assets/1/edit
  def edit
  end

  # POST /slide_assets
  def create
    @slide_asset = SlideAsset.new(slide_asset_params)
    @slide_asset.organization = current_user.organization
    @slide_asset.loop_asset = @loop_asset
    @slide_asset.position = @loop_asset.slide_assets.count

    if @slide_asset.save
      redirect_to @loop_asset, notice: 'Slide was successfuly created.'
    else
      render :new
    end
  end

  # PATCH/PUT /slide_assets/1
  def update
    if @slide_asset.update(slide_asset_params)
      redirect_to @loop_asset, notice: 'Slide was successfully updated.'
    else
      render :edit
    end
  end

  # This is requested by the player software. 
  def htmlsrc
    # Replace hooks in html with relative paths
    htmlstring = @slide_asset.slide_template.markup
    @slide_asset.slide_media_hooks.each { |slide_media_hook|
      htmlstring.gsub! slide_media_hook.hook, slide_media_hook.media_asset.asset_file_file_name
    }

    # Replace addon hooks (includes) in html with relative paths
    htmlstring.gsub!(/__INCLUDE__(.+)__/) { 
      templateaddon = TemplateAddon.where(hook: $1, organization_id: 0).first()
      templateaddon = TemplateAddon.where(hook: $1, organization_id: @slide_asset.organization.id).first() if templateaddon == nil 
      templateaddon ? templateaddon.file_file_name : $1
    }

    render html: htmlstring.html_safe, layout: false
  end

  # This allows a slide preview
  def preview
    # Replace media hooks in html with media urls
    htmlstring = @slide_asset.slide_template.markup
    @slide_asset.slide_media_hooks.each { |slide_media_hook|
      htmlstring.gsub! slide_media_hook.hook, slide_media_hook.media_asset.asset_file.url
    }

    # Replace addon hooks (includes) in html with addon urls
    htmlstring.gsub!(/__INCLUDE__(.+)__/) { 
      templateaddon = TemplateAddon.where(hook: $1, organization_id: 0).first()
      templateaddon = TemplateAddon.where(hook: $1, organization_id: @slide_asset.organization.id).first() if templateaddon == nil 
      templateaddon ? templateaddon.file.url : $1
    }

    render html: htmlstring.html_safe, layout: false
  end

  private

    # Set the loop_asset variable from the param
    def set_loop_asset
      @loop_asset = LoopAsset.find(params[:loop_asset_id])
    end

    def check_loop_asset_ownership
      redirect_to(loop_assets_url) unless current_user.organization == @loop_asset.organization
    end

    def check_loop_asset_ownership_api
      if Player.find(params[:player_id]).organization != @loop_asset.organization
        render nothing: true, status: :unauthorized
      end
    end

    def set_slide_asset
      @slide_asset = @loop_asset.slide_assets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_asset_params
      params.require(:slide_asset).permit(:displayname, :slide_template_id, :duration, :hooks_json_string)
    end
end
