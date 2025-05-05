class RecreateShippingInfosTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :shipping_infos, if_exists: true

    create_table :shipping_infos do |t|
      t.bigint :member_id, null: false
      t.string :postal_code, default: "", null: false
      t.string :country, default: "", null: false
      t.string :prefecture, default: "", null: false
      t.string :city, default: "", null: false
      t.string :address, default: "", null: false
      t.string :building, default: "", null: false
      t.timestamps
    end

    add_index :shipping_infos, :member_id
  end
end
