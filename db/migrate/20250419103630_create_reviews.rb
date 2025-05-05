class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :member, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :title
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
