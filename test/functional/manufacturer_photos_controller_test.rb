require 'test_helper'

class ManufacturerPhotosControllerTest < ActionController::TestCase
  setup do
    @manufacturer_photo = manufacturer_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manufacturer_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manufacturer_photo" do
    assert_difference('ManufacturerPhoto.count') do
      post :create, manufacturer_photo: @manufacturer_photo.attributes
    end

    assert_redirected_to manufacturer_photo_path(assigns(:manufacturer_photo))
  end

  test "should show manufacturer_photo" do
    get :show, id: @manufacturer_photo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manufacturer_photo.to_param
    assert_response :success
  end

  test "should update manufacturer_photo" do
    put :update, id: @manufacturer_photo.to_param, manufacturer_photo: @manufacturer_photo.attributes
    assert_redirected_to manufacturer_photo_path(assigns(:manufacturer_photo))
  end

  test "should destroy manufacturer_photo" do
    assert_difference('ManufacturerPhoto.count', -1) do
      delete :destroy, id: @manufacturer_photo.to_param
    end

    assert_redirected_to manufacturer_photos_path
  end
end
