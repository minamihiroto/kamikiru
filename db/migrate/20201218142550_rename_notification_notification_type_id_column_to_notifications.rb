class RenameNotificationNotificationTypeIdColumnToNotifications < ActiveRecord::Migration[6.0]
  def change
    # active_hashに対してforegn_keyが使えないため、notification_type_idじゃないとうまくリレーションできない
    rename_column :notifications, :notification_notification_type_id, :notification_type_id
  end
end
