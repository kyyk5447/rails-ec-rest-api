class ChangeImageDefaultOnShops < ActiveRecord::Migration[7.1]
  def up
    Shop.where(image: nil).update_all(image: '')
  end

  def down
    Shop.where(image: '').update_all(image: nil)
  end
end
