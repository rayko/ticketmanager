require 'test_helper'

class TickettypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickettypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tickettype" do
    assert_difference('Tickettype.count') do
      post :create, :tickettype => { }
    end

    assert_redirected_to tickettype_path(assigns(:tickettype))
  end

  test "should show tickettype" do
    get :show, :id => tickettypes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tickettypes(:one).to_param
    assert_response :success
  end

  test "should update tickettype" do
    put :update, :id => tickettypes(:one).to_param, :tickettype => { }
    assert_redirected_to tickettype_path(assigns(:tickettype))
  end

  test "should destroy tickettype" do
    assert_difference('Tickettype.count', -1) do
      delete :destroy, :id => tickettypes(:one).to_param
    end

    assert_redirected_to tickettypes_path
  end
end
