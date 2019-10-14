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

end
