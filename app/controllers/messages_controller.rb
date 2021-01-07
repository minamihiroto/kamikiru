class MessagesController < ApplicationController
    def create
        # params[:message][:message_〇〇]はパラメータで送られた:messageの中の一つのカラムを指している
        @message = Message.new(message_content: params[:message][:message_content],message_user_id: params[:message][:message_user_id],message_maching_id: params[:message][:message_maching_id])
        @message.save!
        @maching = Maching.find(params[:message][:message_maching_id])
        # recive_notice_userの中身は、@maching.request_userがログインユーザーであれば => 通知を受ける人は、依頼された人、@maching.request_userがログインユーザーでなければ =>通知を受ける人は、依頼した人と言うことになっている
        recive_notice_user = @maching.request_user == current_user ? @maching.requested_user : @maching.request_user
        Notification.create(notification_user_id: recive_notice_user.id, notification_type_id: 3, notification_maching_id: params[:message][:message_maching_id], notification_message_id: @message.id)
        redirect_to maching_path(@message.message_maching_id)
    end
end
