class RootController < ApplicationController
  skip_before_action :authorize
  def index
  end

  def chatty

  end
end
