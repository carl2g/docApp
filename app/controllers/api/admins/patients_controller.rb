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

	def units
		patient = Patient.find_by(id: params[:patient_id])
		if patient
			render json: patient.units.to_json({only: [:id], include: { general_unit: {only: [:id, :name]}}})
		else
			render json: { errors: "Patient you tried to get modules wasn't found: #{params[:patient_id]}"}, status: :not_found
		end
	end

	def add_unit
		patient = Patient.find_by(id: params[:patient_id])
		if patient
			if patient.addUnit(params[:unit_id])
				render status: :ok
			else
				render json: { errors: "the modules wasn't found: #{params[:unit_id]}"}, status: :not_found
			end
		else
			render json: { errors: "Patient you tried to add modules wasn't found: #{params[:patient_id]}"}, status: :not_found
		end
	end

	def remove_unit
		patient = Patient.find_by(id: params[:patient_id])
		if patient
			if patient.removeUnit(id: params[:unit_id])
				render status: :ok
			else
				render json: { errors: "the modules wasn't found: #{params[:unit_id]}"}, status: :not_found
			end
		else
			render json: { errors: "Patient you tried to add modules wasn't found: #{params[:patient_id]}"}, status: :not_found
		end
	end

	private

		def user_attr
			[:id, :first_name, :last_name, :email, :phone_number, :birthdate, :civility, :picture]
		end

		def permited_params
			params.permit(user_attr)
	 	end
end
