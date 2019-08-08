class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :debugpoint
  before_action :set_user

  def debugpoint
  	# byebug
  end

  def set_user
	  @user = session[:userinfo]
	  unless @user['uid'].nil?
	    @clinician_id = @user['uid'].to_s[0..30]
	  end
    end
end
