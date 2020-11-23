class MachingsController < ApplicationController
    before_action :set_user

    def create
        requesting = current_user.request(@user)
        if requesting.save
          flash[:success] = 'ユーザーに依頼しました'
          redirect_to @user
        else
          flash.now[:alert] = '依頼に失敗しました'
          redirect_to @user
        end
    end

    # 依頼取り消しの機能実装予定はないためコメントアウト
    # def destroy
    #     requesting = current_user.unrequest(@user)
    #     if requesting.destroy
    #       flash[:success] = '依頼を取り消しました'
    #       redirect_to @user
    #     else
    #       flash.now[:alert] = '依頼の取り消しに失敗しました'
    #       redirect_to @user
    #     end
    # end

    private
    def
        @user = User.find(params[:maching][:request_id])
    end

end
