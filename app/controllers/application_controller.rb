class ApplicationController < ActionController::API

	require 'json'

	def current_user
	    @current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
	end

private
    def authenticate_user
	token = request.headers['Authorization']
	if current_user || (token.present? && (user = User.find_by(login_token: token)))
		session[:login_token]		= user.login_token
		session[:current_user_id]	= user.id
	else
		render status: :unauthorized
	end
    end

end
