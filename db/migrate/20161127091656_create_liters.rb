class CreateLiters < ActiveRecord::Migration
  def change
    create_table :liters do |t|
    	t.references :product
    	t.references :package
    	t.float :price    	
      t.timestamps null: false
    end
  end
end
