class Api::SessionsController < ApplicationController

	before_action :authenticate_user, except: [:login]

	def logout
		current_user.update({login_token: nil})
		reset_session
		render status: :ok
	end

	def login
		user = User.authenticate(protected_params[:email], protected_params[:password])

		if user
			session[:login_token] = user.login_token
			render json: { login_token: user.login_token }, status: :ok
		else
			render status: :unauthorized
		end
	end

	def patient_email_confirm
		token = SecureRandom.urlsafe_base64(6)
		SessionMailer.patient_email_confirmation(protected_params, token).deliver_later
		render json: { confirmation_token: token }, status: :ok
	end

protected
	
	def protected_params
		params.require(:session).permit(:email, :password, :name)
	end

end
