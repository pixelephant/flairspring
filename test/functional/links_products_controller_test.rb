require 'test_helper'

class LinksProductsControllerTest < ActionController::TestCase
  setup do
    @links_product = links_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:links_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create links_product" do
    assert_difference('LinksProduct.count') do
      post :create, links_product: @links_product.attributes
    end

    assert_redirected_to links_product_path(assigns(:links_product))
  end

  test "should show links_product" do
    get :show, id: @links_product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @links_product.to_param
    assert_response :success
  end

  test "should update links_product" do
    put :update, id: @links_product.to_param, links_product: @links_product.attributes
    assert_redirected_to links_product_path(assigns(:links_product))
  end

  test "should destroy links_product" do
    assert_difference('LinksProduct.count', -1) do
      delete :destroy, id: @links_product.to_param
    end

    assert_redirected_to links_products_path
  end
end
