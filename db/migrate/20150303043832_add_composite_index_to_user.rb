class AddCompositeIndexToUser < ActiveRecord::Migration
  def change
    add_index :users, [:alert_hour, :alert_minute]
  end
end
