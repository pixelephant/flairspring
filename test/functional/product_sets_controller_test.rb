require 'test_helper'

class ProductSetsControllerTest < ActionController::TestCase
  setup do
    @product_set = product_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_set" do
    assert_difference('ProductSet.count') do
      post :create, product_set: @product_set.attributes
    end

    assert_redirected_to product_set_path(assigns(:product_set))
  end

  test "should show product_set" do
    get :show, id: @product_set.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_set.to_param
    assert_response :success
  end

  test "should update product_set" do
    put :update, id: @product_set.to_param, product_set: @product_set.attributes
    assert_redirected_to product_set_path(assigns(:product_set))
  end

  test "should destroy product_set" do
    assert_difference('ProductSet.count', -1) do
      delete :destroy, id: @product_set.to_param
    end

    assert_redirected_to product_sets_path
  end
end
