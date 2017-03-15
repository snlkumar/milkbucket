class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date, default: Date.today
      t.references :client
      t.timestamps null: false
    end
  end
end
