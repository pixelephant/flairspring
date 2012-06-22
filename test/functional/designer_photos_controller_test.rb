require 'test_helper'

class DesignerPhotosControllerTest < ActionController::TestCase
  setup do
    @designer_photo = designer_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:designer_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create designer_photo" do
    assert_difference('DesignerPhoto.count') do
      post :create, designer_photo: @designer_photo.attributes
    end

    assert_redirected_to designer_photo_path(assigns(:designer_photo))
  end

  test "should show designer_photo" do
    get :show, id: @designer_photo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @designer_photo.to_param
    assert_response :success
  end

  test "should update designer_photo" do
    put :update, id: @designer_photo.to_param, designer_photo: @designer_photo.attributes
    assert_redirected_to designer_photo_path(assigns(:designer_photo))
  end

  test "should destroy designer_photo" do
    assert_difference('DesignerPhoto.count', -1) do
      delete :destroy, id: @designer_photo.to_param
    end

    assert_redirected_to designer_photos_path
  end
end
