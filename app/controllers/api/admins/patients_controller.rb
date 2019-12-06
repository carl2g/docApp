class Api::Admins::PatientsController < Api::Admins::AdminsController
	before_action :authenticate_user, except: [:is_admin?]

	def update
		patient = Patient.find_by(id: params[:id])
		if patient.update(permited_params.except(:id))
			render json: {}, status: :ok
		else
			render json: {}, status: :unprocessable_entity
		end
	end

	private
	
		def permited_params
			params.require(:patient).permit(user_attributes: [:first_name, :last_name, :email, :phone_number, :birthdate, :civility, :picture])
	 	end

end
