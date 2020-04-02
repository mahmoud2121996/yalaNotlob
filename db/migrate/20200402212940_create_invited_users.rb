class CreateInvitedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :invited_users do |t|
      t.references :user, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :order, foreign_key: {to_table: :orders, on_delete: :cascade}, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
