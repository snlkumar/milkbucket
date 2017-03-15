class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|      
      t.float :price
      t.integer :quantity
      t.references :order
      t.references :item
      t.timestamps null: false
    end
  end
end
