# app/controllers/logout_controller.rb

class LogoutController < ApplicationController
  include LogoutHelper
  def logout
    reset_session
    redirect_to logout_url.to_s
  end
end