require 'test_helper'

class Admin::HardwareTypesControllerTest < ActionController::TestCase
  setup do
    @admin_hardware_type = admin_hardware_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_hardware_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_hardware_type" do
    assert_difference('Admin::HardwareType.count') do
      post :create, admin_hardware_type: { description: @admin_hardware_type.description, model_number: @admin_hardware_type.model_number }
    end

    assert_redirected_to admin_hardware_type_path(assigns(:admin_hardware_type))
  end

  test "should show admin_hardware_type" do
    get :show, id: @admin_hardware_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_hardware_type
    assert_response :success
  end

  test "should update admin_hardware_type" do
    patch :update, id: @admin_hardware_type, admin_hardware_type: { description: @admin_hardware_type.description, model_number: @admin_hardware_type.model_number }
    assert_redirected_to admin_hardware_type_path(assigns(:admin_hardware_type))
  end

  test "should destroy admin_hardware_type" do
    assert_difference('Admin::HardwareType.count', -1) do
      delete :destroy, id: @admin_hardware_type
    end

    assert_redirected_to admin_hardware_types_path
  end
end
