class AddRouteToTrips < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :route, null: false, foreign_key: true
  end
end
