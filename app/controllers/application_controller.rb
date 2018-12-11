class ApplicationController < ActionController::API

	require 'json'

	def current_user
	    @current_user ||= session[:current_user_id] &&
      		User.find_by(id: session[:current_user_id])
  	end

private

    def authenticate_user
    	token = request.headers['Authorization']
    	if current_user || (token.present? && (user = User.find_by_login_token(token)))
    		session[:token] 			= user.login_token
    		session[:current_user_id] 	= user.id
    	else
    		# redirect_to api_login_path
    	end
    end

end
