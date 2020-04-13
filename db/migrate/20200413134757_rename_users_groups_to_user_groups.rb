class RenameUsersGroupsToUserGroups < ActiveRecord::Migration[6.0]
  def change
    rename_table :users_groups, :user_groups
  end
end
