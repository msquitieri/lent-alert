class AddHourAndMinuteToUser < ActiveRecord::Migration
  def change
    add_column :users, :alert_hour, :integer
    add_column :users, :alert_minute, :integer
  end
end
