class OverviewController < ApplicationController
  include FlashMessages
  include AuthenticateUser
  before_action :logged_in_user

  def index
    @media_assets_count = current_user.organization.media_assets.count
    @media_assets_total_size = current_user.organization.media_assets.sum(:asset_file_file_size)
    @loop_assets_count  = current_user.organization.loop_assets.count
    @loop_assets_duration = 0
    current_user.organization.loop_assets.each{ |loop_asset| @loop_assets_duration += loop_asset.slide_assets.sum(:duration) }
    @players_count      = current_user.organization.players.count
    @active_players_count = current_user.organization.players.where.not(campaign_id: nil).count
    @campaigns_count    = current_user.organization.campaigns.count
    @active_campaigns_count = current_user.organization.campaigns.where(id: current_user.organization.players.pluck(:campaign_id)).count
    @logs = current_user.organization.user_logs.last(10).reverse
    @online_players_count = current_user.organization.players.where(["last_connection >= ?", 1.day.ago]).count
    @offline_players_count = current_user.organization.players.where(["last_connection < ?", 1.day.ago]).count
    @pending_players_count = current_user.organization.players.where(activated: false).count
  end
end
