class Api::Patients::DoctorsController < ApplicationController

	before_action :authenticate_user

	def index
		doctors = Doctor.users.select(:id, :first_name, :last_name, :email)
		render json: { doctors: doctors }, status: :ok
	end

	def my_doctors
		doctors = current_patient.doctors.users.select(:id, :first_name, :last_name, :email)
		render json: { doctors: doctors }, status: :ok
	end

	# def doctors
	# 	doctors = current_patient.doctors.map { |d| d.user }
	# 	render json: { doctors: doctors }
	# end

	def add_doctor
		if current_patient.addDoctor(Doctor.find_by(id: params[:id]))
			render json: {}, status: :ok
		else
			render json: { :errors => patient.errors.full_messages }, status: :not_found
		end
	end

	def remove_doctor
		doctor = Doctor.find_by(id: params[:id])
		current_patient.doctors.pop(doctor)
		if current_patient.save
			render json: {}, status: :ok
		else
			render json: { :errors => patient.errors.full_messages }, status: :not_found
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
