class CreateReleaseInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :release_infos do |t|
      t.string :title
      t.text :body
      t.integer :status
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
