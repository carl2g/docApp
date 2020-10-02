class Api::Patients::NotesController < Api::Patients::ApplicationController

	def destroy
		note = current_patient.notes.find_by(id: params[:id])
		if note && note.destroy
			render json: {}, status: :ok
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

	def update
		note = current_patient.notes.find_by(id: params[:id])
		if note && note.update({data: params[:data], date: Time.parse(params[:date])})
			render json: note.to_json(only: [:id, :data, :date]), status: :ok
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

	def index
		notes = current_patient.notes
		render json: notes.to_json(only: [:id, :data]), status: :ok
	end

	def notes_by_date_interval
		date_begin = params[:begin_date]
		date_end = params[:end_date]
		unit = params[:unit]

		if date_begin && date_end && unit
			notes = current_patient.notes_from_unit(unit)
			range = (date_begin + " 00:00:00"..date_end + " 23:59:59")
			results = notes.select { |note| range.cover?(note.date) }.map do |m|
				{
					id: m.id,
					unit_id: m.unit_id,
					data: m.data,
					date: m.date,
					doctor_ids: m.doctor_ids
				}
			end
			render json: results.to_json, status: :ok
		else
			render json: { errors: "Missing parameters" }, status: :unprocessable_entity
		end
	end

	def unshare
		note = current_patient.notes.find_by(id: params[:note_id])
		doctor_ids = params[:doctor_ids]
		if doctor_ids
			shared_notes = note.doctor_unit_notes.joins(:doctor_unit).where(doctor_units: {doctor_id: doctor_ids})
			shared_notes.each do |note|
				note.destroy
			end
			render json: shared_notes.to_json(only: [:note_id]), status: :ok
		else
			render json: { errors: "Missing parameters" }, status: :unprocessable_entity
		end
	end

	def doctors
		note = current_patient.notes.find_by(id: params[:note_id])
		if note
			render json: note.doctors.to_json({
				only: [:id],
				include: {
					user: { only: user_data },
				}
			})
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

	def doctor_note_filter
		note = current_patient.doctor_unit_notes.find_by(note_id: params[:note_id])
		if note
			render json: note.to_json(only: [:note_id, :filter]), status: :ok
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

private

	def permited_params
		params.require(:note).permit(:data, :filter)
	end

	def user_data
    [
      :first_name,
      :last_name,
      :email
    ]
  end

end
