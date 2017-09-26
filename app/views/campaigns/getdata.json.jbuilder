json.mainloop @campaign.loop_campaign_hooks.where(play_info: 'main').take.loop_asset.uuid
json.specific @campaign.loop_campaign_hooks.where(play_info: 'specific') do |hook|
	json.start_year hook.start_year
	json.start_month hook.start_month
	json.start_day hook.start_day
	json.start_hour hook.start_hour
	json.start_minute hook.start_minute
	json.start_second hook.start_second

	json.end_year hook.end_year
	json.end_month hook.end_month
	json.end_day hook.end_day
	json.end_hour hook.end_hour
	json.end_minute hook.end_minute
	json.end_second hook.end_second

	json.loop hook.loop_asset.uuid
end

json.weekly @campaign.loop_campaign_hooks.where(play_info: 'weekly') do |hook|
	json.start_year hook.start_year
	json.start_month hook.start_month
	json.start_day hook.start_day
	json.start_hour hook.start_hour
	json.start_minute hook.start_minute
	json.start_second hook.start_second

	json.end_year hook.end_year
	json.end_month hook.end_month
	json.end_day hook.end_day
	json.end_hour hook.end_hour
	json.end_minute hook.end_minute
	json.end_second hook.end_second

	json.repeat_info hook.repeat_info
	json.loop hook.loop_asset.uuid
end
json.monthly @campaign.loop_campaign_hooks.where(play_info: 'monthly') do |hook|
	json.start_year hook.start_year
	json.start_month hook.start_month
	json.start_day hook.start_day
	json.start_hour hook.start_hour
	json.start_minute hook.start_minute
	json.start_second hook.start_second

	json.end_year hook.end_year
	json.end_month hook.end_month
	json.end_day hook.end_day
	json.end_hour hook.end_hour
	json.end_minute hook.end_minute
	json.end_second hook.end_second

	json.loop hook.loop_asset.uuid
end