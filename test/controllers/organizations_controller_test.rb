require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  setup do
    @organization = organizations(:one)
    @soadmin = users(:soadmin)
    @orgadmin = users (:orgadmin)
    @reguser = users(:reguser)
  end

  test "should get index" do
    log_in_as(@soadmin)
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations)
  end

  test "should get new" do
    log_in_as(@soadmin)
    get :new
    assert_response :success
  end

  test "should create organization" do
    log_in_as(@soadmin)
    assert_difference('Organization.count') do
      post :create, organization: { email: @organization.email, name: @organization.name, phone: @organization.phone }
    end

    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should show organization" do
    log_in_as(@reguser)
    get :show, id: @organization
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@orgadmin)
    get :edit, id: @organization
    assert_response :success
  end

  test "should update organization" do
    log_in_as(@orgadmin)
    patch :update, id: @organization, organization: { email: @organization.email, name: @organization.name, phone: @organization.phone }
    assert_redirected_to @organization
    assert_equal flash[:notice], 'Organization was successfully updated.'
  end

  test "should deny non org admin to update" do
    log_in_as(@reguser)
    patch :update, id: @organization, organization: { email: @organization.email, name: @organization.name, phone: @organization.phone }
    assert_redirected_to @organization
    assert_not_equal flash[:notice], 'Organization was successfully updated.'
  end

  test "should destroy organization" do
    log_in_as(@soadmin)
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization
    end

    assert_redirected_to organizations_path
  end
end
