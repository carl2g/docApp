class Api::Doctors::DoctorsController < ApplicationController
	before_action :authenticate_user, except: [:signin]

	def signin
		if params[:default_units].present?
			doctor = Doctor.createDoctor(params)
			if doctor.persisted?
				session[:current_doctor_id] 	= doctor.id
				session[:login_token] 		= doctor.login_token
				render json: { login_token: doctor.login_token }, status: :created
			else
				render json: { :errors => doctor.errors.full_messages }, status: :unprocessable_entity
			end
		else
			render json: { :errors => "Need default units to create the doctor" }, status: :bad_request
		end
	end

private

	def permited_params
		[
			:first_name,
			:last_name,
			:password,
			:phone_number,
			:email,
			:picture,
			:default_units,
			:address
		]
	end

	def permited
		params.permit(permited_params)
	end

end
