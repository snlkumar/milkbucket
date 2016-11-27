class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :name
    	t.boolean :active, default: true
    	t.references :category
    	t.float :halfltr
    	t.float :oneltr
    	t.float :sixltr
      t.timestamps null: false
    end
  end
end
