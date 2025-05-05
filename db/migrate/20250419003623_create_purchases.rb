class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :member, null: false, foreign_key: true
      t.integer :total_price

      t.timestamps
    end
  end
end
