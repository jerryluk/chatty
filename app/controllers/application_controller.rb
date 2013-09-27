class ApplicationController < ActionController::Base
  include Edmofu::Controllers::Helpers
  before_action :authorize
  before_action :set_edmodo_user_id
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected
  def set_edmodo_user_id
    if current_user and current_user.edmodo_user_id.blank?
      current_user.edmodo_user_id = session[:edmodo_id]
      current_user.save!
    end
  end
end
