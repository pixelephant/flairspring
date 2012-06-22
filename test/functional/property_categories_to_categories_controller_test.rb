require 'test_helper'

class PropertyCategoriesToCategoriesControllerTest < ActionController::TestCase
  setup do
    @property_categories_to_category = property_categories_to_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:property_categories_to_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property_categories_to_category" do
    assert_difference('PropertyCategoriesToCategory.count') do
      post :create, property_categories_to_category: @property_categories_to_category.attributes
    end

    assert_redirected_to property_categories_to_category_path(assigns(:property_categories_to_category))
  end

  test "should show property_categories_to_category" do
    get :show, id: @property_categories_to_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property_categories_to_category.to_param
    assert_response :success
  end

  test "should update property_categories_to_category" do
    put :update, id: @property_categories_to_category.to_param, property_categories_to_category: @property_categories_to_category.attributes
    assert_redirected_to property_categories_to_category_path(assigns(:property_categories_to_category))
  end

  test "should destroy property_categories_to_category" do
    assert_difference('PropertyCategoriesToCategory.count', -1) do
      delete :destroy, id: @property_categories_to_category.to_param
    end

    assert_redirected_to property_categories_to_categories_path
  end
end
