class Campaign < ActiveRecord::Base
	attr_accessor :hooks_json_string
	has_many :players
	belongs_to :organization
	has_many :loop_campaign_hooks, :dependent => :destroy
	has_many :loop_assets, :through => :loop_campaign_hooks
	has_many :user_logs, as: :loggable

	validates :displayname, presence: true, length: { in: 2..20 }
	validates :organization, presence: true

	before_create :generate_uuid
	before_save :handle_loop_assets

	after_save :bubble_update

	before_destroy :check_for_parents

	# Work this update up the chain to flag an update on the player
	def bubble_update
    	players.each{ |player| 
    	  player.bubble_update
    	}
  	end

	private
		def generate_uuid
			self.uuid = SecureRandom.uuid
		end

		def handle_loop_assets
			return if self.hooks_json_string == nil || self.hooks_json_string.empty?

			# parse the json from the javacript campaign gerator webapp
			hooks_meta_array = JSON.parse(self.hooks_json_string)

			hooks_in_use = Array.new

			# Make sure main loop is present
			return false if hooks_meta_array[0]['play_info'] != 'main'

			# loop through each proposed hook
			hooks_meta_array.each_with_index { |hook_meta_object, index|
				# make sure this is a weekly entry (unless its the main)
				return false if index < 0 && hooks_meta_object['play_info'] != 'weekly'

				if hook_meta_object['id'] == nil
					# CREATE A NEW HOOK
					hook_asset = self.loop_campaign_hooks.build(hook_meta_object)
					hook_asset.save!
				else
					# EDIT AN EXISTING HOOK
					hook_asset = self.loop_campaign_hooks.find(hook_meta_object['id'])
					hook_asset.update(hook_meta_object)
				end

				hooks_in_use << hook_asset
			}

			# Marks the old unused slides for deletion
			self.loop_campaign_hooks = hooks_in_use
		end

		def check_for_parents
			if players.any?
				errors.add(:base, "#{displayname} cannot be deleted. It is in use by at least one campaign.")
				return false
			end
		end
end
