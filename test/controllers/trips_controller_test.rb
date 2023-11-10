require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get the trips" do
   get trips_path
   assert_response :success
  end

  test "show create a new trip" do
    route=Route.create(code: 'ruta test' , name: 'test5')
    post trips_path, params: {trips:[{code: "new trip test", name: "trip 1", route_id: route.id}] }
    assert_response :success
  end

  test "show not create a trip if route_id not exist " do
    post trips_path, params: {trips:[{code: "new trip test", name: "trip 1", route_id:"ruta no existe"}] }
    assert_response 400
  end

  test "show not create a trip if any route_id not exist " do
    route=Route.create(code: 'ruta test2' , name: 'test2')
    post trips_path, params: {trips:[{code: "trip with route", name: "trip 1", route_id:route.id},{code: "new trip test", name: "trip 2", route_id:"ruta no existe"}] }
    assert_response 400
  end

end
