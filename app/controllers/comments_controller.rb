class CommentsController < ApplicationController
  def index
    @request_user = current_user.request_users.eager_load(:reverse_of_machings).where(machings: { aggree: false })
    @requested_user = current_user.requested_users.eager_load(:machings).where(machings: { aggree: false })
    @approve_request_user = current_user.request_users.eager_load(:reverse_of_machings).where(machings: { aggree: true })
    @approve_requested_user  = current_user.requested_users.eager_load(:machings).where(machings: { aggree: true })
  end

  def main
    @users = User.all
  end
end
