class MessagesController < ApplicationController
    def create
        @message = Message.new(message_content: params[:message][:message_content],message_user_id: params[:message][:message_user_id],message_maching_id: params[:message][:message_maching_id])
        @message.save!
        redirect_to maching_path(@message.message_maching_id)
    end
end
