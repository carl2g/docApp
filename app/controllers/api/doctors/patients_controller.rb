class Api::Doctors::PatientsController < ApplicationController
	before_action :authenticate_user

	def index
		user_attrs = [:id, :email, :first_name, :last_name]
		patients = current_doctor.patients
		render json: patients.to_json({
			only: [:id],
			include: {
				user: { only: user_attrs }
			}
		}), status: :ok
	end

end
