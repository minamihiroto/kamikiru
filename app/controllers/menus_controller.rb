class MenusController < ApplicationController
  def create
    @request_user = current_user.request_users.eager_load(:reverse_of_machings).where(machings: { aggree: false })
    @requested_user = current_user.requested_users.eager_load(:machings).where(machings: { aggree: false })
    @approve_request_user = current_user.request_users.eager_load(:reverse_of_machings).where(machings: { aggree: true })
    @approve_requested_user  = current_user.requested_users.eager_load(:machings).where(machings: { aggree: true })
    @menus = current_user.menus
    @menu = Menu.new(name: params[:menu][:name],fee: params[:menu][:fee],user_id: current_user.id)
    if @menu.valid?
      @menu.save
      redirect_to root_path
    else
      render "comments/index"
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    redirect_to root_path
  end
end
