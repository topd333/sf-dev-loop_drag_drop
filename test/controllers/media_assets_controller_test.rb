require 'test_helper'

class MediaAssetsControllerTest < ActionController::TestCase
  setup do
    @media_asset = media_assets(:one)
    log_in_as(users(:reguser))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should create media_asset" do
  #   assert_difference('MediaAsset.count') do
  #     post :create, media_asset: { displayname: @media_asset.displayname, asset_file: @media_asset.asset_file, media_type: @media_asset.media_type, organization_id: @media_asset.organization_id, size: @media_asset.size, thumbnail: @media_asset.thumbnail }
  #   end

  #   assert_redirected_to media_asset_path(assigns(:media_asset))
  # end

  test "should show media_asset" do
    get :show, id: @media_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @media_asset
    assert_response :success
  end

  # test "should update media_asset" do
  #   patch :update, id: @media_asset, media_asset: { displayname: @media_asset.displayname, asset_file: @media_asset.asset_file, media_type: @media_asset.media_type, organization_id: @media_asset.organization_id, size: @media_asset.size, thumbnail: @media_asset.thumbnail }
  #   assert_redirected_to media_asset_path(assigns(:media_asset))
  # end

  test "should destroy media_asset" do
    assert_difference('MediaAsset.count', -1) do
      delete :destroy, id: @media_asset
    end

    assert_redirected_to media_assets_path
  end
end
