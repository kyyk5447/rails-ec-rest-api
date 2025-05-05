class ChangeItemsDefaults < ActiveRecord::Migration[7.1]
  def change
    change_column_default :items, :price, 0
    change_column_null :items, :price, false

    change_column_default :items, :stock, 0
    change_column_null :items, :stock, false

    change_column_default :items, :status, 0
    change_column_null :items, :status, false
  end
end
