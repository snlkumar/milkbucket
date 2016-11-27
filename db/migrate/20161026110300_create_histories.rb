class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :data
      t.timestamps null: false
    end
  end
end
