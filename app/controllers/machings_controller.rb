class MachingsController < ApplicationController
    before_action :set_user,only:[:create]

    def create
      # @userはrequestメソッド(user.rbのメソッド)のother_userにはいる（引数に入る）
        requesting = current_user.request(@user)
        if requesting.save
          flash[:success] = 'ユーザーに依頼しました'
          redirect_to comments_main_path
        else
          flash.now[:alert] = '依頼に失敗しました'
          redirect_to comments_main_path
        end
    end

    def update
      maching = current_user.reverse_of_machings.find_by(request_user_id: params[:id])
      maching.update(aggree: true)
      redirect_to root_path
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