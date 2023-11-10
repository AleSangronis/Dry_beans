class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.string :address
      t.string :order_type

      t.timestamps
    end
  end
end
