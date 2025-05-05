class AddConstraintsToShops < ActiveRecord::Migration[7.1]
  def change
    change_column :shops, :name, :string, limit: 30, default: '', null: false
    change_column :shops, :description, :text, limit: 300, default: '', null: false
  end
end
