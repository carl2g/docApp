class Api::Doctors::PatientsController < ApplicationController
	before_action :authenticate_user

	# try to send data by acceding via units and not patients
	def index
		units = current_doctor.units
		render json: units.to_json({
			only: [:id, :patient_id],
			include: {
				general_unit: { only: [:id, :name] }
			}
		}), status: :ok
	end

	def profile
		patient = Patient.find_by(id: params[:id])
		if patient
			render json: patient.user.to_json(only: user_attr), status: :ok
		else
			render json: { errors: "Patient you tried to get profile informations doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

private

	def user_attr
		[
			:first_name,
			:last_name,
			:phone_number,
			:email,
			:civility,
      :birthdate,
      :picture
		]
	end

	def permited_params
		params.require(:id)
	end

end
