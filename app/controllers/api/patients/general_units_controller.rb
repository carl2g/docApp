class Api::Patients::GeneralUnitsController < Api::Patients::ApplicationController

	def index
		modules = GeneralUnit.select(:color, :icon, :id, :name).as_json
		user_modules = current_patient.units.pluck(:general_unit_id)
		modules = modules.map do |mod|
			tmp = mod.dup
			if user_modules.include?(tmp["id"])
				tmp["already_added"] = true
			else
				tmp["already_added"] = false
			end
			tmp
		end
		render json: { modules: modules }, status: :ok
	end

	def add
		if current_patient.addUnit(params[:general_unit_id])
			render json: {}, status: :ok
		else
			render json: { errors: current_patient.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def info
		unit = GeneralUnit.find_by(id: params[:general_unit_id])
		if unit
			render json: unit.to_json(), status: :ok
		else
			render json: { errors: "no general_unit found with id: #{params[:general_unit_id]}" }, status: :not_found
		end
	end

	def doctors
		doctors = Doctor.joins(:general_unit_doctors).where(general_unit_doctors: {general_unit_id: params[:general_unit_id]})
		if !doctors.blank?
			render json: doctors.to_json({only: [:id],
					include: {
						user: { only: [:first_name, :last_name]}
					}
				 }), status: :ok
		else
			render json: { errors: "There is no doctor for this module or this module doesn't exist: #{params[:general_unit_id]}" }, status: :not_found
		end
	end

	def note_model
		g_id = params[:general_unit_id]

		g_unit = GeneralUnit.find(g_id)

		if g_unit
			render json: g_unit.note_model, status: :ok
		else
			render json: { errors: "This module doesn't exist: #{g_id}" }, status: :not_found
		end
	end

	def get_note_fileds
		id = params[:general_unit_id]
		gu = GeneralUnit.find(id)

		if gu
			fileds = gu.note_model.map {|e| e["tag"] }
			render json: fileds, status: :ok
		else
			render json: { errors: "This module doesn't exist: #{id}" }, status: :not_found

		end
		
	end

end
