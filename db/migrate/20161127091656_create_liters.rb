class CreateLiters < ActiveRecord::Migration
  def change
    create_table :liters do |t|
    	t.string :name
    	t.float :price
    	t.boolean :isactive, default: :true
      t.timestamps null: false
    end
  end
end
