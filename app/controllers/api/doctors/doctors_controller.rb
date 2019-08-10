class Api::Doctors::DoctorsController < ApplicationController
	before_action :authenticate_user, except: [:signin]

	def signin
		if params[:default_units].present?
			doctor = Doctor.createDoctor(permited, params[:default_units])
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

	def add_unit
		if current_doctor.addUnit(params[:unit])
			render json: {}, status: :ok
		else
			render json: { :errors => "Couldn't add the unit cause you either already have it or the unit doesn't exist" }, status: :unprocessable_entity
		end
	end

	def remove_unit
		if current_doctor.removeUnit(params[:unit])
			render json: {}, status: :ok
		else
			render json: { :errors => "Couldn't remove the unit cause you don't have it" }, status: :unprocessable_entity
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
		params.permit(permited_params)
	end

end
