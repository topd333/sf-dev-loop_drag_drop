class LoopCampaignHook < ActiveRecord::Base
  belongs_to :loop_asset
  belongs_to :campaign, touch: true

  validates :loop_asset, presence: true
  validates :campaign, presence:true
  validates :play_info, inclusion: { in: %w(main weekly), message: '%{value} is not a valid entry type' }

  after_save :bubble_update

  # Work this update up the chain to flag an update on the player
  def bubble_update 
    campaign.bubble_update
  end
end
