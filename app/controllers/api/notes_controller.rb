class Api::NotesController < ApplicationController

	before_action :authenticate_user

	def create
		note = Note.generateNote(params[:module_id], params[:data], current_patient)
		if note.save
			render json: { }, status: :ok
		else
			render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
		end
	end

end
