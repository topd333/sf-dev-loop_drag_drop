class SlideAddonHook < ActiveRecord::Base
	belongs_to :organization
	belongs_to :slide_asset, touch: true
	belongs_to :slide_addon

	validates :organization, presence: true
	validates :slide_asset, presence: true
	validates :slide_addon, presence: true

	after_save :buble_update

	# Work this update up the chain to flag an update on the player
	def bubble_update
		slide_asset.bubble_update
	end
end