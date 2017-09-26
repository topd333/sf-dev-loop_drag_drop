json.id @player.id
json.name @player.name
json.currentCampaignUuid @player.campaign ? @player.campaign.uuid : nil
json.lastUpdate @player.last_update_stamp

if @player.pending_action
	actions = [@player.pending_action] 
	json.pendingActions actions do |action|
		json.action action
	end
end
