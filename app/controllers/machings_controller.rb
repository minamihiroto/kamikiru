class MachingsController < ApplicationController
    before_action :set_user,only:[:create]

    def create
      # 依頼アクション
      # @userはrequestメソッド(user.rbのメソッド)のother_userにはいる（引数に入る）
      requesting = current_user.request(@user)
      if requesting.save
        flash[:success] = 'ユーザーに依頼しました'
        Notification.create(notification_user_id: @user.id, notification_notification_type_id: 1)
        redirect_to comments_main_path
      else
        flash.now[:alert] = '依頼に失敗しました'
        redirect_to comments_main_path
      end
    end

    def update
      # 承認アクション
      # ログインしてるユーザー(requested_user)に依頼したユーザー(request_user)のマッチングを取得
      # ログインしてるユーザーが中間テーブル(「セルフ（ログインしてるユーザー）に依頼したユーザー」とのマッチング)を呼び出し、依頼してきたユーザーを引数に入れている
      maching = current_user.reverse_of_machings.find_by(id: params[:id])
      maching.update(aggree: true)
      recive_notice_user = maching.request_user_id
      Notification.create(notification_user_id: recive_notice_user, notification_notification_type_id: 2)
      redirect_to root_path
    end

    def show
      @maching = Maching.find_by(id: params[:id])
       # メッセージアクション
      if @maching.request_user == current_user || @maching.requested_user == current_user
        @messages = Message.where(message_maching_id: params[:id])
        @message = Message.new
      else
        redirect_to root_path
      end
    end

    # 依頼取り消しの機能実装予定はないためコメントアウト
    # def destroy
    #     requesting = current_user.unrequest(@user)
    #     if requesting.destroy
    #       flash[:success] = '依頼を取り消しました'
    #       redirect_to comments_main_path
    #     else
    #       flash.now[:alert] = '依頼の取り消しに失敗しました'
    #       redirect_to comments_main_path
    #     end
    # end

    # このコントローラ内でしか使わないためprivateと記述
    private
    def set_user
        # リクエストされるユーザーのデータが入る
        @user = User.find params[:request_user_id]
    end
end