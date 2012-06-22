require 'test_helper'

class PropertyCategoriesControllerTest < ActionController::TestCase
  setup do
    @property_category = property_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:property_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property_category" do
    assert_difference('PropertyCategory.count') do
      post :create, property_category: @property_category.attributes
    end

    assert_redirected_to property_category_path(assigns(:property_category))
  end

  test "should show property_category" do
    get :show, id: @property_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property_category.to_param
    assert_response :success
  end

  test "should update property_category" do
    put :update, id: @property_category.to_param, property_category: @property_category.attributes
    assert_redirected_to property_category_path(assigns(:property_category))
  end

  test "should destroy property_category" do
    assert_difference('PropertyCategory.count', -1) do
      delete :destroy, id: @property_category.to_param
    end

    assert_redirected_to property_categories_path
  end
end
