class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ここから追加します
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, images: []]) # 新規登録時(sign_up時)にname,imagesというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, images: []]) # name,imagesの編集を許可する

  end
  # ここまで追加します
end
