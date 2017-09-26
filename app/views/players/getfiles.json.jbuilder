json.currentCampaignUuid @player.campaign ? @player.campaign.uuid : nil
json.lastUpdate @player.last_update_stamp

file_metas = [];
if campaign = @player.campaign
	
	campaign_meta = [{'uuid' => campaign.uuid, 'url' => getdata_campaign_path(campaign, :only_path => false, :format => :json), 'stamp' => campaign.updated_at}]
	file_metas.concat campaign_meta

	campaign.loop_assets.each do |loop_asset|
		loop_meta = [{'uuid' => loop_asset.uuid, 'url' => getdata_loop_asset_path(loop_asset, :only_path => false, :format => :json), 'stamp' => loop_asset.updated_at}]
		file_metas.concat loop_meta

		loop_asset.slide_assets.each do |slide|
			slide_meta = [{'uuid' => slide.uuid, 'url' => htmlsrc_loop_asset_slide_asset_path(loop_asset, slide, :only_path => false)+'.html', 'stamp' => slide.updated_at}]
			file_metas.concat slide_meta

			slide.media_assets.each do |media|
				media_meta = [{'uuid' => media.asset_file_file_name, 'url' => image_url(media.asset_file.url), 'stamp' => media.asset_file_updated_at}]
				file_metas.concat media_meta
			
			end
		end
	end
end

json.files file_metas