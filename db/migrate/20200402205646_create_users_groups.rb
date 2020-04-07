class CreateUsersGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :users_groups do |t|
      t.references :user, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :group, foreign_key: {to_table: :groups, on_delete: :cascade}, null: false
      t.timestamps
    end
  end
end
