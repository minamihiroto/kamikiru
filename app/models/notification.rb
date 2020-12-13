class Notification < ApplicationRecord
  # 〇〇_active_hashを使うための記述
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :notification_type
  belongs_to :notification_user, class_name: 'User'
end
