class Api::Patients::NotesController < ApplicationController

	before_action :authenticate_user

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
		if note && note.update({data: params[:data]})
			render json: note.to_json(only: [:id, :data]), status: :ok
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

	def index
		notes = current_patient.notes
		render json: notes.to_json(only: [:id, :data]), status: :ok
	end

	def notes_by_date_interval
		date_begin = params[:begin_date].to_date
		date_end = params[:end_date].to_date
		notes = current_patient.notes

		if date_begin && date_end
			range = (date_begin..date_end)
			results = notes.select { |note| range.cover?(note.created_at) }
			render json: results.to_json, status: :ok
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

private

	def permited_params
		params.require(:note).permit(:data)
	end

	def user_data
    [
      :first_name,
      :last_name,
      :email
    ]
  end

end
