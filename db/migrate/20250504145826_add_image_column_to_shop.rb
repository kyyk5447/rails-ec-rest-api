class AddImageColumnToShop < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :image, :string
  end
end
