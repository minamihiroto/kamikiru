class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :notification_message, foreign_key: { to_table: :messages }, comment: "DMのメッセージ"
      t.references :notification_user, null: false,　foreign_key: { to_table: :users }, comment: "通知を受けるユーザー"
      t.references :notification_maching, foreign_key: { to_table: :maching }, comment: "DMしてる部屋"
      t.references :notification_notification_type, null: false, foreign_key: { to_table: :notification_types }, comment: "お知らせの種類"
      t.boolean :notification_read, default: false, comment: "既読判定"
      t.timestamps
    end
  end
end
