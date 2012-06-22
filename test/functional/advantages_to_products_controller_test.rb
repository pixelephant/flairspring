require 'test_helper'

class AdvantagesToProductsControllerTest < ActionController::TestCase
  setup do
    @advantages_to_product = advantages_to_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advantages_to_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create advantages_to_product" do
    assert_difference('AdvantagesToProduct.count') do
      post :create, advantages_to_product: @advantages_to_product.attributes
    end

    assert_redirected_to advantages_to_product_path(assigns(:advantages_to_product))
  end

  test "should show advantages_to_product" do
    get :show, id: @advantages_to_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @advantages_to_product.to_param
    assert_response :success
  end

  test "should update advantages_to_product" do
    put :update, id: @advantages_to_product.to_param, advantages_to_product: @advantages_to_product.attributes
    assert_redirected_to advantages_to_product_path(assigns(:advantages_to_product))
  end

  test "should destroy advantages_to_product" do
    assert_difference('AdvantagesToProduct.count', -1) do
      delete :destroy, id: @advantages_to_product.to_param
    end

    assert_redirected_to advantages_to_products_path
  end
end
