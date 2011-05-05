require 'test_helper'

class TxtsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:txts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create txt" do
    assert_difference('Txt.count') do
      post :create, :txt => { }
    end

    assert_redirected_to txt_path(assigns(:txt))
  end

  test "should show txt" do
    get :show, :id => txts(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => txts(:one).id
    assert_response :success
  end

  test "should update txt" do
    put :update, :id => txts(:one).id, :txt => { }
    assert_redirected_to txt_path(assigns(:txt))
  end

  test "should destroy txt" do
    assert_difference('Txt.count', -1) do
      delete :destroy, :id => txts(:one).id
    end

    assert_redirected_to txts_path
  end
end
