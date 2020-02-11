class Api::Admins::NotesController < Api::Admins::AdminsController
	before_action :authenticate_user, except: [:signin]  # TODO: remove
	before_action :authenticate_user, except: [:is_admin?] #TODO: put back

	def update
		note = Note.find_by(id: params[:id])
		if note.update(permited_params)
			render json: {}, status: :ok
		else
			render json: {}, status: :unprocessable_entity
		end
	end

	def create
		if Note.create(permited_params)
			render json: {}, status: :ok
		else
			render json: {}, status: :unprocessable_entity
		end
	end

	private

		def permited_params
			params.require(:note).permit([:unit_id, :data])
	 	end

end
