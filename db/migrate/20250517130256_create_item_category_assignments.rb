class CreateItemCategoryAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :item_category_assignments do |t|
      t.references :item, null: false, foreign_key: true
      t.references :item_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
