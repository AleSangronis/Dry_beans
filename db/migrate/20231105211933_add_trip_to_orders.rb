class AddTripToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :trip, null: true, foreign_key: true
  end
end
