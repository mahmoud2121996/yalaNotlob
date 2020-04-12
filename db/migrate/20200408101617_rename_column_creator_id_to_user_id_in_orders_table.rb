class RenameColumnCreatorIdToUserIdInOrdersTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :creator_id, :user_id
  end
end
