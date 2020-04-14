class ChangeReadColumnInNotifications < ActiveRecord::Migration[6.0]
  def change
    change_table :notifications do |t|
      t.rename :read, :read_at
      t.change :read_at, :datetime, null: true
    end
  end
end
