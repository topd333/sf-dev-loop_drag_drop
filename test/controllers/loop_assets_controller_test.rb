require 'test_helper'

class LoopAssetsControllerTest < ActionController::TestCase
  setup do
    @loop_asset = loop_assets(:one)
    log_in_as(users(:reguser))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loop_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should create loop_asset" do
  #   assert_difference('LoopAsset.count') do
  #     post :create, loop_asset: { displayname: @loop_asset.displayname, organization_id: @loop_asset.organization_id }
  #   end

  #   assert_redirected_to loop_asset_path(assigns(:loop_asset))
  # end

  test "should show loop_asset" do
    get :show, id: @loop_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loop_asset
    assert_response :success
  end

  # test "should update loop_asset" do
  #   patch :update, id: @loop_asset, loop_asset: { displayname: @loop_asset.displayname, organization_id: @loop_asset.organization_id }
  #   assert_redirected_to loop_asset_path(assigns(:loop_asset))
  # end

  test "should destroy loop_asset" do
    assert_difference('LoopAsset.count', -1) do
      delete :destroy, id: @loop_asset
    end

    assert_redirected_to loop_assets_path
  end
end
