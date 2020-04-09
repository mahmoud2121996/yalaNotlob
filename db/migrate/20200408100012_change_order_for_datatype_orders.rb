class ChangeOrderForDatatypeOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :order_for, :string
  end
end
