class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		doctors = Doctor.getInfos
		render json: { doctors: doctors }, status: :ok
	end

	def my_doctors
		doctors = current_patient.getDoctorsInfo
		render json: { doctors: doctors }, status: :ok
	end

	def add_doctor
		if current_patient.addDoctor(params[:doctor_id], params[:module_id])
			render json: {}, status: :ok
		else
			render json: { :errors => current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def remove_doctor
		if current_patient.removeDoctor(params[:doctor_id], params[:module_id])
			render json: {}, status: :ok
		else
			render json: { :errors => current_patient.errors.full_messages }, status: :unprocessable_entity
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
