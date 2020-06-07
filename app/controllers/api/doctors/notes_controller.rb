class Api::Doctors::NotesController < Api::Doctors::ApplicationController

	def index
		render json: current_doctor.notes, status: :ok
	end

	def notes_by_date_interval
		date_begin = params[:begin_date]
		date_end = params[:end_date]
		unit = params[:unit]

		if date_begin && date_end && unit
			range = (date_begin + " 00:00:00"..date_end + " 23:59:59")
			notes = current_doctor.notes_by_date_interval_unit(unit, range)
			render json: notes.to_json, status: :ok
		else
			render json: { errors: "Missing parameters" }, status: :unprocessable_entity
		end
	end

end
