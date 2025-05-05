class ChangeImageDefaultOnItems < ActiveRecord::Migration[7.1]
  def up
    Item.where(image: nil).update_all(image: "")
  end

  def down
    Item.where(image: "").update_all(image: nil)
  end
end
