require 'test_helper'

class MassUploadsControllerTest < ActionController::TestCase
  setup do
    @mass_upload = mass_uploads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mass_uploads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mass_upload" do
    assert_difference('MassUpload.count') do
      post :create, mass_upload: @mass_upload.attributes
    end

    assert_redirected_to mass_upload_path(assigns(:mass_upload))
  end

  test "should show mass_upload" do
    get :show, id: @mass_upload.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mass_upload.to_param
    assert_response :success
  end

  test "should update mass_upload" do
    put :update, id: @mass_upload.to_param, mass_upload: @mass_upload.attributes
    assert_redirected_to mass_upload_path(assigns(:mass_upload))
  end

  test "should destroy mass_upload" do
    assert_difference('MassUpload.count', -1) do
      delete :destroy, id: @mass_upload.to_param
    end

    assert_redirected_to mass_uploads_path
  end
end
