class RootController < ApplicationController
  skip_before_action :authorize, only: [:chatty]
  def index
    @chats = Chat.active_for(current_user).order("chats.updated_at DESC").all#page(params[:page])
    @chat_form = ChatForm.new
  end

  def chatty
    session[:edmodo_id] = params[:edmodo_id]
  end
end
