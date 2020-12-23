class Notification < ApplicationRecord
  # 〇〇_active_hashを使うための記述
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :notification_type
  belongs_to :notification_user, class_name: 'User'
  # foreign_key:を使っているとデフォルトでnullが許可されないのでoptional: trueをつけてnullを許可する
  belongs_to :notification_message, class_name: 'Message',optional: true
end
