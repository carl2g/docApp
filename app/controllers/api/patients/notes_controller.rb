class Api::Patients::NotesController < ApplicationController

	before_action :authenticate_user

	def destroy
		note = current_patient.notes.find_by(id: params[:id])
		if note && note.destroy
			render json: { }, status: :ok
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

	def update
		note = current_patient.notes.find_by(id: params[:id])
		if note && note.update({data: params[:data].to_json})
			render json: { message: "Note successfully updated" }, status: :ok
		else
			render json: { errors: "Note not found" }, status: :not_found
		end
	end

	def index
		notes = current_patient.notes
		render json: notes.to_json(only: [:id, :data]), status: :ok
	end

private

	def permited_params
		params.require(:note).permite(:data)
	end

end
