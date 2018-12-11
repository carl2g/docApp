class Api::UsersController < ApplicationController

	before_action :authenticate_user, except: [:login]

	def signin
		user = User.new(permited)

		if user.save
			session[:current_user_id] 	= user.id
			session[:token] 			= user.login_token
			render json: { token: user.login_token }, status: :created
		else
			render json: { :errors => user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def logout
		current_user.update({login_token: nil})
		reset_session
		render status: :ok
	end

	def login
		user = User.authenticate(params[:email], params[:password])
		user ||= User.find_by_login_token(request.headers['Authorization'])

		if user
			session[:token] = user.login_token
			render json: { token: user.login_token }, status: :found
		else
			render status: :not_found
		end
	end

private

	def permited_params
		[
			:first_name, 
			:last_name, 
			:password,
			:phone_number,
			:email
		]
	end
	
	def permited
		params.require(:user).permit(permited_params)
	end

end