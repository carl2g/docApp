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
