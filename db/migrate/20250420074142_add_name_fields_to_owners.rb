class AddNameFieldsToOwners < ActiveRecord::Migration[7.1]
  def change
    add_column :owners, :first_name, :string, null: false, default: '', limit: 20
    add_column :owners, :last_name, :string, null: false, default: '', limit: 20
    add_column :owners, :first_name_kana, :string, null: false, default: '', limit: 20
    add_column :owners, :last_name_kana, :string, null: false, default: '', limit: 20
  end
end