require 'test_helper'

class CallsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create call" do
    assert_difference('Call.count') do
      post :create, :call => { }
    end

    assert_redirected_to call_path(assigns(:call))
  end

  test "should show call" do
    get :show, :id => calls(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => calls(:one).id
    assert_response :success
  end

  test "should update call" do
    put :update, :id => calls(:one).id, :call => { }
    assert_redirected_to call_path(assigns(:call))
  end

  test "should destroy call" do
    assert_difference('Call.count', -1) do
      delete :destroy, :id => calls(:one).id
    end

    assert_redirected_to calls_path
  end
end
