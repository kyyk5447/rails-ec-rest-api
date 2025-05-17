class CreateShopCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :shop_categories, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end 