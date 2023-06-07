class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :end_user_id, null: false
      t.integer :cat_id, null: false

      t.timestamps
    end
  end
end
