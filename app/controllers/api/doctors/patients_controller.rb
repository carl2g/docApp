class Api::Doctors::PatientsController < ApplicationController
	before_action :authenticate_user

	def index
		user_attrs = [:id, :email, :first_name, :last_name, :birthdate, :civility]
		patients = current_doctor.patients.distinct
		render json: patients.to_json({ except: [:id, :user_id],
			:name => "lololol",
			include: {
				user: { only: user_attrs },
				general_units: { only: [:id, :name] }
			}
		}), status: :ok
	end

end
