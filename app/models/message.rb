class Message < ApplicationRecord
    belongs_to :message_user, class_name: 'User'
    belongs_to :message_maching, class_name: 'Maching'

    has_many :notifications, foreign_key: :notification_message_id
end
