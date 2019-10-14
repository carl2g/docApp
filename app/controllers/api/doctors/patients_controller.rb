class Api::Doctors::PatientsController < ApplicationController
	before_action :authenticate_user

	# try to send data by acceding via units and not patients
	def index
		patients = current_doctor.patients
		render json: patients.to_json({
			only: [:id, :unit_id],
			include: {
				general_unit: { only: [:id, :name] }
			}
		}), status: :ok
	end

end
