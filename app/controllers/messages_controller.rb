class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
    @message.chat.read_messages!(current_user)
  end
end
