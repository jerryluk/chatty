class ChatsController < ApplicationController

  def index
    @chats = Chat.active_for(current_user).order("chats.updated_at DESC").page(params[:page])
    respond_with @chats
  end
end
