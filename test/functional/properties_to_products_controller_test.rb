require 'test_helper'

class PropertiesToProductsControllerTest < ActionController::TestCase
  setup do
    @properties_to_product = properties_to_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties_to_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create properties_to_product" do
    assert_difference('PropertiesToProduct.count') do
      post :create, properties_to_product: @properties_to_product.attributes
    end

    assert_redirected_to properties_to_product_path(assigns(:properties_to_product))
  end

  test "should show properties_to_product" do
    get :show, id: @properties_to_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @properties_to_product.to_param
    assert_response :success
  end

  test "should update properties_to_product" do
    put :update, id: @properties_to_product.to_param, properties_to_product: @properties_to_product.attributes
    assert_redirected_to properties_to_product_path(assigns(:properties_to_product))
  end

  test "should destroy properties_to_product" do
    assert_difference('PropertiesToProduct.count', -1) do
      delete :destroy, id: @properties_to_product.to_param
    end

    assert_redirected_to properties_to_products_path
  end
end
