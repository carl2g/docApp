class Api::Patients::PatientsController < ApplicationController

	before_action :authenticate_user, except: [:signin]

	def signin
		patient = Patient.createPatient(permited)

		if patient.persisted?
			session[:current_patient_id] 	= patient.id
			session[:login_token] 		= patient.login_token
			render json: { login_token: patient.login_token }, status: :created
		else
			render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def index
		user_attrs = [:id, :email, :first_name, :last_name, :birthdate, :civility]
		render json: current_patient.user.to_json({only: user_attrs}), status: :ok
	end

private

	def permited_params
		[
			:first_name,
			:last_name,
			:password,
			:phone_number,
			:email,
			:civility,
			:birthdate
		]
	end

	def permited
		params.permit(permited_params)
	end
end
