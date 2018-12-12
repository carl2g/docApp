class Api::DoctorsController < ApplicationController

	before_action :authenticate_doctor, except: [:login, :signin]

	def signin
		doctor = Doctor.createDoctor(permited)

		if doctor.save
			session[:current_doctor_id] = doctor.id
			session[:token] 			= doctor.login_token
			render json: { token: doctor.login_token }, status: :created
		else
			render json: { :errors => doctor.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def logout
		current_doctor.update({login_token: nil})
		reset_session
		render status: :ok
	end

	def login
		doctor = Doctor.authenticate(params[:email], params[:password])
		doctor ||= Doctor.joins(:user).where(users: { login_token: request.headers['Authorization'] } ).first

		if doctor
			session[:token] = doctor.login_token
			render json: { token: doctor.login_token }, status: :found
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
		params.require(:doctor).permit(permited_params)
	end

end