require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get all orders" do
    get orders_path
    assert_response :success
  end

  test "should create a new order" do
    route=Route.create(code: 'route' , name: 'routest')
    trips=Trip.create(code: 'trip test', route_id: route.id)
    post orders_path , params: {orders:[{code: 'new order' , address: 'direccion', trip_id:trips.id}]}
    assert_response :success
  end

  test "should not create a new order" do
    post orders_path , params: {orders:[{code: 'new order' , address: 'direccion', trip_id:2}]}
    assert_response 400
  end
  
end
