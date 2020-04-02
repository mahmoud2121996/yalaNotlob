class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.references :user, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.references :order, foreign_key: {to_table: :orders, on_delete: :cascade}, null: false
      t.string :item_name, null: false
      t.integer :amount, null: false
      t.decimal :price, null: false
      t.string :comment
      t.timestamps
    end
  end
end
