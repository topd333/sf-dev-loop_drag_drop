module MediaAssetsHelper
  def asset_classes(asset)
    ret = ""
    ret << " item-#{asset.id}"
    ret << " image" if asset.is_image?
    ret << " video" if asset.is_video?
    ret
  end

  def build_preview_icon(media_asset)

    #<MediaAsset id: 163, organization_id: 1, displayname: "shutterstock_157219784.jpg", created_at: "2015-04-09 20:55:31", updated_at: "2015-04-09 20:55:31", asset_file_file_name: "b711ac66-a7f8-4840-98ce-35c977b7c7af.jpg", asset_file_content_type: "image/jpeg", asset_file_file_size: 7010081, asset_file_updated_at: "2015-04-09 20:55:29", asset_file_meta: nil, duration: nil>
    lightbox = "asset-image-#{media_asset.id}"
    title = media_asset.displayname
    href = media_asset.asset_file.url

    # if media_asset.is_image?
    #   rel = ""
    # elsif media_asset.is_video?
    #   rel = "lightvideo"
    # end

    content_tag :a, href: href, class: "show-preview-link #{media_asset.id} pull-left html5lightbox" do
      content_tag(:i, "", class: "glyphicon glyphicon-fullscreen")
    end

  end
end
