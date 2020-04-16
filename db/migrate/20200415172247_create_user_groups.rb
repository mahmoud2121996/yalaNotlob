class CreateUserGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups do |t|
      t.references :user, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :group, foreign_key: {to_table: :groups, on_delete: :cascade}, null: false
      t.timestamps
    end
  end
end
