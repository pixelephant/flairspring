require 'test_helper'

class CustomCategoriesControllerTest < ActionController::TestCase
  setup do
    @custom_category = custom_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_category" do
    assert_difference('CustomCategory.count') do
      post :create, custom_category: @custom_category.attributes
    end

    assert_redirected_to custom_category_path(assigns(:custom_category))
  end

  test "should show custom_category" do
    get :show, id: @custom_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @custom_category.to_param
    assert_response :success
  end

  test "should update custom_category" do
    put :update, id: @custom_category.to_param, custom_category: @custom_category.attributes
    assert_redirected_to custom_category_path(assigns(:custom_category))
  end

  test "should destroy custom_category" do
    assert_difference('CustomCategory.count', -1) do
      delete :destroy, id: @custom_category.to_param
    end

    assert_redirected_to custom_categories_path
  end
end
