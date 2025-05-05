class AddConstraintsToItems < ActiveRecord::Migration[7.1]
  def change
    change_column :items, :name, :string, limit: 30, default: "", null: false
    change_column :items, :description, :text, limit: 300, default: "", null: false
  end
end
