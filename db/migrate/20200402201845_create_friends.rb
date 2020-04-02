class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :friend, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.timestamps
    end
  end
end
