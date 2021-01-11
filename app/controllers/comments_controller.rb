class CommentsController < ApplicationController
  def index
    if current_user
    @request_user = current_user.request_users.eager_load(:reverse_of_machings).where(machings: { aggree: false })
    @requested_user = current_user.requested_users.eager_load(:machings).where(machings: { aggree: false })
    @approve_request_user = current_user.request_users.eager_load(:reverse_of_machings).where(machings: { aggree: true })
    @approve_requested_user  = current_user.requested_users.eager_load(:machings).where(machings: { aggree: true })
    @menu = Menu.new
    @menus = current_user.menus
    else
      redirect_to new_user_session_path
    end
  end

  def main
    @menus = Menu.search(params[:keyword])
  end
end
