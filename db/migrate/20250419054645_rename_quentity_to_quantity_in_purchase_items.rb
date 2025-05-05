class RenameQuentityToQuantityInPurchaseItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :purchase_items, :quentity, :quantity
  end
end
