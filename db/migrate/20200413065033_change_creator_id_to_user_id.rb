class ChangeCreatorIdToUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :groups, :creator_id, :user_id
  end
end
