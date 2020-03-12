class Api::Admins::PatientsController < Api::Admins::AdminsController

	def index
		data = []
		Patient.find_each do |pat|
		  data.push(pat.user)
		end
		attributes = user_attr.concat([:id])
		attributes.delete(:picture)
		render json: data.to_json(only: attributes), status: :ok
	end

	def update
		patient = Patient.find_by(user_id: params[:id])
		if patient.update(permited_params)
			render json: patient.user.to_json(only: user_attr), status: :ok
		else
			render json: { errors: "Patient you tried to update informations doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	def delete
		patient = Patient.find_by(user_id: params[:id])
		if patient
			User.delete(id: params[:id])
		  patient.destroy
		  render status: :ok
		else
		  render json: { errors: "Patient you tried to delete doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	private

		def user_attr
			[:first_name, :last_name, :email, :phone_number, :birthdate, :civility, :picture]
		end

		def permited_params
			params.permit(user_attributes: user_attr)
	 	end
end
