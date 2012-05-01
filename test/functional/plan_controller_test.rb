require 'test_helper'

class PlanControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get cabinet" do
    get :cabinet
    assert_response :success
  end

  test "should get kp_titl" do
    get :kp_titl
    assert_response :success
  end

  test "should get kp_lit" do
    get :kp_lit
    assert_response :success
  end

  test "should get kp_body" do
    get :kp_body
    assert_response :success
  end

  test "should get kp_print" do
    get :kp_print
    assert_response :success
  end

  test "should get whoareyou" do
    get :whoareyou
    assert_response :success
  end

end
