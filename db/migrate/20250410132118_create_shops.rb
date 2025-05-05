class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
