class Api::Doctors::NotesController < Api::Doctors::ApplicationController

	def index
		render json: current_doctor.notes, status: :ok
	end

end
