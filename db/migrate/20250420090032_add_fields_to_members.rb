class AddFieldsToMembers < ActiveRecord::Migration[7.0]
  def change
    change_table :members, bulk: true do |t|
      t.string :first_name, null: false, default: '', limit: 20
      t.string :first_name_kana, null: false, default: '', limit: 20
      t.string :last_name, null: false, default: '', limit: 20
      t.string :last_name_kana, null: false, default: '', limit: 20
      t.string :tel, null: false, default: '', limit: 15
      t.integer :gender, null: false, default: 1
      t.date :birthday
    end
  end
end
