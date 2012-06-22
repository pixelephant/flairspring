require 'test_helper'

class PropertiesToCustomCategoriesControllerTest < ActionController::TestCase
  setup do
    @properties_to_custom_category = properties_to_custom_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties_to_custom_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create properties_to_custom_category" do
    assert_difference('PropertiesToCustomCategory.count') do
      post :create, properties_to_custom_category: @properties_to_custom_category.attributes
    end

    assert_redirected_to properties_to_custom_category_path(assigns(:properties_to_custom_category))
  end

  test "should show properties_to_custom_category" do
    get :show, id: @properties_to_custom_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @properties_to_custom_category.to_param
    assert_response :success
  end

  test "should update properties_to_custom_category" do
    put :update, id: @properties_to_custom_category.to_param, properties_to_custom_category: @properties_to_custom_category.attributes
    assert_redirected_to properties_to_custom_category_path(assigns(:properties_to_custom_category))
  end

  test "should destroy properties_to_custom_category" do
    assert_difference('PropertiesToCustomCategory.count', -1) do
      delete :destroy, id: @properties_to_custom_category.to_param
    end

    assert_redirected_to properties_to_custom_categories_path
  end
end
