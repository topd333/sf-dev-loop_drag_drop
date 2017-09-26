json.id @loop_asset.id
json.slides @loop_asset.slide_assets do |slide|
	json.id slide.id
	json.uuid slide.uuid
	json.duration slide.duration
	json.htmlsrc loop_asset_slide_asset_url(@loop_asset, slide) + '.json'
end

