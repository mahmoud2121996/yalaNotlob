class ChangeNotifications < ActiveRecord::Migration[6.0]
  def change
    change_table :notifications do |t|
      t.rename :type, :notification_type
      t.change :read, :datetime , :default => nil
      t.boolean :reacted, :after =>  :read, null: false, :default => false
   end
  end
end
