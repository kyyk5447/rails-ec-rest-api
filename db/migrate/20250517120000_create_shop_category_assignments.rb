class CreateShopCategoryAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :shop_category_assignments do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :shop_category, null: false, foreign_key: true

      t.timestamps
    end

    # 同じショップ-カテゴリの組み合わせを防ぐためのユニーク制約
    add_index :shop_category_assignments, [:shop_id, :shop_category_id], unique: true
  end
end 