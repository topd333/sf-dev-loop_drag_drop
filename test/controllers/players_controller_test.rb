require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
    @reguser = users(:reguser)
    @orgadmin = users(:orgadmin)
    @soadmin = users(:soadmin)
  end

  test "should get index" do
    log_in_as(@reguser)
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    log_in_as(@orgadmin)
    get :new
    assert_response :success
  end

  test "should create player" do
    log_in_as(@orgadmin)
    assert_difference('Player.count') do
      post :create, player: { description: @player.description, name: @player.name, organization_id: @player.organization_id }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    log_in_as(@reguser)
    get :show, id: @player
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@reguser)
    get :edit, id: @player
    assert_response :success
  end

  test "should update player" do
    log_in_as(@reguser)
    patch :update, id: @player, player: { description: @player.description, name: @player.name, organization_id: @player.organization_id }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    log_in_as(@orgadmin)
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_redirected_to players_path
  end
end
