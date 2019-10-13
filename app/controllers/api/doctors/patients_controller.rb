class Api::Doctors::PatientsController < ApplicationController
	before_action :authenticate_user

	# try to send data by acceding via units and not patients
	def index
		user_attrs = [:id, :email, :first_name, :last_name, :birthdate, :civility]

		patients = current_doctor.units

		render json: patients.to_json({ only: [:patient_id],
			include: {
				general_unit: { only: [:id, :name] }
			}
		}), status: :ok
	end

end
