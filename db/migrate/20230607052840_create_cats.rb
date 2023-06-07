class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.integer :end_user_id, null: false
      t.string :name, null: false
      t.text :introduction
      t.integer :sex, null: false, default: 0

      t.timestamps
    end
  end
end
