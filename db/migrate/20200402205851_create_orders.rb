class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :order_for, null: false
      t.integer :status, null: false
      t.string :restaurant, null: false
      t.string :menu_pic
      t.references :creator, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.integer :invited, default: 0
      t.integer :joined, default: 0
      t.timestamps
    end
  end
end
