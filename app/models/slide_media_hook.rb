class SlideMediaHook < ActiveRecord::Base
  belongs_to :organization
  belongs_to :slide_asset, touch: true
  belongs_to :media_asset

  validates :organization, presence: true
  validates :slide_asset, presence: true
  validates :media_asset, presence:true

  after_save :bubble_update

  # Work this update up the chain to flag an update on the player
  def bubble_update 
    slide_asset.bubble_update
  end
end
