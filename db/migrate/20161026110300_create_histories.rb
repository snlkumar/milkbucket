class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :particular
      t.string :slot
      t.string :debit
      t.string :balance
      t.string :credit
      t.string :bank
      t.timestamps null: false
    end
  end
end
