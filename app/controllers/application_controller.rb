class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :mark_notification_read!, if: :is_before_notification_pages?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :flag, images: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :flag, images: []])
  end

  def mark_notification_read!
    # ログインしていたら、未読の通知をとってきて、それを既読に更新する
    if current_user
      unread_notification = current_user.notifications.where(notification_read: false)
      unread_notification.update(notification_read: true)
    end
  end

  # /notificationsが以前のページだったことをとってこれる
  # is_...?はtrueかfalseを返す時に使う定義の命名規則
  def is_before_notification_pages?
    request.referer&.include?("/notifications")
  end

end
