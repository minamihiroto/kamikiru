class CommentsController < ApplicationController
  def index
    @request_user = Maching.request_user(current_user)
    @requested_user = Maching.requested_user(current_user).where.not(requested_user_id: current_user)
  end

  def main
    @users = User.all
  end
end
