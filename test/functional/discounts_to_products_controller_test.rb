require 'test_helper'

class DiscountsToProductsControllerTest < ActionController::TestCase
  setup do
    @discounts_to_product = discounts_to_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discounts_to_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discounts_to_product" do
    assert_difference('DiscountsToProduct.count') do
      post :create, discounts_to_product: @discounts_to_product.attributes
    end

    assert_redirected_to discounts_to_product_path(assigns(:discounts_to_product))
  end

  test "should show discounts_to_product" do
    get :show, id: @discounts_to_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discounts_to_product.to_param
    assert_response :success
  end

  test "should update discounts_to_product" do
    put :update, id: @discounts_to_product.to_param, discounts_to_product: @discounts_to_product.attributes
    assert_redirected_to discounts_to_product_path(assigns(:discounts_to_product))
  end

  test "should destroy discounts_to_product" do
    assert_difference('DiscountsToProduct.count', -1) do
      delete :destroy, id: @discounts_to_product.to_param
    end

    assert_redirected_to discounts_to_products_path
  end
end
