class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :stock
      t.integer :status
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
