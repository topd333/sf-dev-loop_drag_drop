require 'test_helper'

class Admin::PayProgramsControllerTest < ActionController::TestCase
  setup do
    @admin_pay_program = admin_pay_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_pay_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_pay_program" do
    assert_difference('Admin::PayProgram.count') do
      post :create, admin_pay_program: { available: @admin_pay_program.available, description: @admin_pay_program.description, name: @admin_pay_program.name, period: @admin_pay_program.period, price: @admin_pay_program.price }
    end

    assert_redirected_to admin_pay_program_path(assigns(:admin_pay_program))
  end

  test "should show admin_pay_program" do
    get :show, id: @admin_pay_program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_pay_program
    assert_response :success
  end

  test "should update admin_pay_program" do
    patch :update, id: @admin_pay_program, admin_pay_program: { available: @admin_pay_program.available, description: @admin_pay_program.description, name: @admin_pay_program.name, period: @admin_pay_program.period, price: @admin_pay_program.price }
    assert_redirected_to admin_pay_program_path(assigns(:admin_pay_program))
  end

  test "should destroy admin_pay_program" do
    assert_difference('Admin::PayProgram.count', -1) do
      delete :destroy, id: @admin_pay_program
    end

    assert_redirected_to admin_pay_programs_path
  end
end
