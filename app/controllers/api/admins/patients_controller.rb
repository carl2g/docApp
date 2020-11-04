class Api::Admins::PatientsController < Api::Admins::AdminsController

	def index
		data = []
		attributes = user_attr
		attributes.delete(:picture)
		attributes.delete(:id)
		Patient.find_each do |pat|
		  data.push(pat.to_json({
				only: [:id],
				include: {
					user: {only: attributes},
					units: {only: [:id]}
				}
			}))
		end
		render json: data, status: :ok
	end

	def update
		patient = Patient.find_by(id: params[:id])
		if patient && patient.user.update(permited_params)
			render json: patient.user.to_json(only: user_attr), status: :ok
		else
			render json: { errors: "Patient you tried to update informations doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	def delete
		patient = Patient.find_by(id: params[:patient_id])
		if patient
			User.delete(id: params[:patient_id])
		  patient.destroy
		  render status: :ok
		else
		  render json: { errors: "Patient you tried to delete doesn't exist: #{params[:patient_id]}" }, status: :not_found
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

	def add_doctor
		patient = Patient.find_by(id: params[:patient_id])

		if !patient
			render json: { errors: "Patient doesn't exist: #{params[:patient_id]}" }, status: :not_found
		else
			patient_unit = patient.units.find_by(id: params[:unit_id])
			if patient_unit
				if patient_unit.addDoctor(params[:doctor_id])
					render json: {}, status: :ok
				else
					render json: { errors: "Patient already has this Doctor or he doesn't exist : #{params[:doctor_id]}" }, status: :not_found
				end
			else
				render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
			end
		end
	end

	def remove_doctor
		patient = Patient.find_by(id: params[:patient_id])

		if !patient
			render json: { errors: "Patient doesn't exist: #{params[:patient_id]}" }, status: :not_found
		else
			patient_unit = patient.units.find_by(id: params[:unit_id])
			if patient_unit
				if patient_unit.removeDoctor(params[:doctor_id])
					render json: {}, status: :ok
				else
					render json: { errors: "Patient already has this Doctor or he doesn't exist : #{params[:doctor_id]}" }, status: :not_found
				end
			else
				render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
			end
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
