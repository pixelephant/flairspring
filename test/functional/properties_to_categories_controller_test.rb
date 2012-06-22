require 'test_helper'

class PropertiesToCategoriesControllerTest < ActionController::TestCase
  setup do
    @properties_to_category = properties_to_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties_to_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create properties_to_category" do
    assert_difference('PropertiesToCategory.count') do
      post :create, properties_to_category: @properties_to_category.attributes
    end

    assert_redirected_to properties_to_category_path(assigns(:properties_to_category))
  end

  test "should show properties_to_category" do
    get :show, id: @properties_to_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @properties_to_category.to_param
    assert_response :success
  end

  test "should update properties_to_category" do
    put :update, id: @properties_to_category.to_param, properties_to_category: @properties_to_category.attributes
    assert_redirected_to properties_to_category_path(assigns(:properties_to_category))
  end

  test "should destroy properties_to_category" do
    assert_difference('PropertiesToCategory.count', -1) do
      delete :destroy, id: @properties_to_category.to_param
    end

    assert_redirected_to properties_to_categories_path
  end
end
