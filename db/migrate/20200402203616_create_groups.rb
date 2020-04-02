class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :creator, foreign_key: {to_table: :users, on_delete: :cascade}, null: false
      t.timestamps
    end
  end
end
