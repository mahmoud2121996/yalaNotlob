class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :from, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :to, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :order, foreign_key: {to_table: :orders, on_delete: :cascade}
      t.integer :type, null: false
      t.boolean :read, null: false
      t.timestamps

    end
  end
end
