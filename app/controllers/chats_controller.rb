class ChatsController < ApplicationController
  respond_to :json, :js

  def index
    @chats = Chat.active_for(current_user).order("chats.updated_at DESC").page(params[:page])
    respond_with @chats
  end

  def show
    @chat = Chat.all_for(current_user).find(params[:id])
    @chat.read_messages!(current_user)
  end

  def create
    @chat_form = ChatForm.new(params.require(:chat_form).permit(:user_ids, :subject, :content))
    @chat_form.user = current_user
    if @chat_form.save
      @chat = @chat_form.chat
      @message = @chat_form.message
      render
    else
      render text: @chat_form.errors.full_messages
    end
  end
end
