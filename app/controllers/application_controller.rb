class ApplicationController < ActionController::API

	require 'json'

	def current_user
	    @current_user ||= session[:current_user_id] &&
			User.where( users: { id: session[:current_user_id] } ).first
	end

private

    def authenticate_doctor
	token = request.headers['Authorization']
	puts "=" * 100
	puts token
	puts "=" * 100
	if current_user || (token.present? && (user = User.where( users: { login_token: token } ).first))
		puts token

		session[:token]			= user.login_token
		session[:current_user_id]	= user.id
	else
		render status: :unauthorized
	end
    end

end
