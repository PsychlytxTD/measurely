class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :debugpoint

  def debugpoint
  	# byebug
  end

  def set_user
	  @user = session[:userinfo]
	  unless @user['uid'].nil?
	    @clinician_id = @user['uid'].to_s[6..30]
	  end
    end
end
