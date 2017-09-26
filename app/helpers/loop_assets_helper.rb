module LoopAssetsHelper

  def  build_image_tag(loop_asset)
    if loop_asset.slide_assets.count > 0
      image_tag(loop_asset.slide_assets.first.thumb_path, height: '170', width: '240', class: "group asset-image")
    else
      image_tag("placeholder.jpg", height: '170', width: '240', class: "group asset-image")
    end
  end

  def media_asset_type(slide)
    slide.media_asset.is_image? ? "image" : "video"
  end

end
