class CommentsController < ApplicationController
  def index
    # 自分自身(current_user)が依頼したデータ(Machingテーブルのrequested_user_id)を参照する
    @request_user = Maching.request_user(current_user)
    # 自分自身(current_user)が依頼されたデータ(Machingテーブルのrequest_user_id)を参照する
    @requested_user = current_user.requested_users.eager_load(:machings).where(machings: { aggree: false })
    @users = User.all
    @approve = current_user.requested_users.eager_load(:machings).where(machings: { aggree: true })
  end

  def main
    @users = User.all
  end
end
