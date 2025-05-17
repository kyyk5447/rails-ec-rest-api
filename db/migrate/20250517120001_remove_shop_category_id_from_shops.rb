class RemoveShopCategoryIdFromShops < ActiveRecord::Migration[7.1]
  def change
    remove_column :shops, :shop_category_id, :bigint, if_exists: true
  end
end 