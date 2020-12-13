class NotificationType < ActiveHash::Base
  self.data = [
    {id: 1, name: 'マッチング依頼', notify_message: "マッチング依頼が届きました"}, 
    {id: 2, name: 'マッチング承認', notify_message: "マッチングが承認されました"}, 
    {id: 3, name: 'メッセージ到着', notify_message: "メッセージが届きました"}, 
  ]

  has_many :notification
end
