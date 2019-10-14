class Api::Doctors::NotesController < ApplicationController
	before_action :authenticate_user
	
	def index
		render json: current_doctor.notes, status: :ok
	end

end
