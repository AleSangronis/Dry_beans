class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :code  #Para que la orden tenga un codigo identificador
      t.string :address #Direccion de la entrega
      t.string :order_type #Hace referencia a si es entrega y/o retiro

      t.timestamps
    end
  end
end
