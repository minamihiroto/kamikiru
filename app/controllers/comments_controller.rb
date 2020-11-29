class CommentsController < ApplicationController
  def index
    # 自分自身(current_user)が依頼したデータ(Machingテーブルのrequest_user_id)を参照する
    @request_user = Maching.request_user(current_user)
    # 自分自身(current_user)が依頼されたデータ(Machingテーブルのrequested_user_id)を参照する
    @requested_user = Maching.requested_user(current_user)
  end

  def main
    @users = User.all
  end
end
