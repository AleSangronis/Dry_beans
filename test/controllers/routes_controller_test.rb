require 'test_helper'

class RoutesControllerTest < ActionDispatch::IntegrationTest

test "should get the routes with their trips and deliveries" do
    get routes_path
    assert_response :success
  end

  test "should create a route" do
    assert_difference "Route.count" do
    post routes_path, params: {routes:[{name: "test", code: "test1"}] }
    end
    assert_response :success
  end

  test "should failed a route" do
    post routes_path, params: {routes:[{}] }
    assert_response 400
  end


end