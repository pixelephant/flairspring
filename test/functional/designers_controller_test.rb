require 'test_helper'

class DesignersControllerTest < ActionController::TestCase
  setup do
    @designer = designers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:designers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create designer" do
    assert_difference('Designer.count') do
      post :create, designer: @designer.attributes
    end

    assert_redirected_to designer_path(assigns(:designer))
  end

  test "should show designer" do
    get :show, id: @designer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @designer.to_param
    assert_response :success
  end

  test "should update designer" do
    put :update, id: @designer.to_param, designer: @designer.attributes
    assert_redirected_to designer_path(assigns(:designer))
  end

  test "should destroy designer" do
    assert_difference('Designer.count', -1) do
      delete :destroy, id: @designer.to_param
    end

    assert_redirected_to designers_path
  end
end
