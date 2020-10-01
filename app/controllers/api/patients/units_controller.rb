class Api::Patients::UnitsController < Api::Patients::ApplicationController

	def add_doctor
		patient_unit = current_patient.units.find_by(id: params[:unit_id])

		if !patient_unit
			render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
		else
			puts params[:doctor_id]
			if patient_unit.addDoctor(params[:doctor_id])
				render json: {}, status: :ok
			else
				render json: { errors: "Patient already has this Doctor or he doesn't exist : #{params[:doctor_id]}" }, status: :not_found
			end
		end
	end

	def remove_doctor
		patient_unit = current_patient.units.find_by(id: params[:unit_id])

		if patient_unit.nil?
			render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
		else
			if patient_unit.removeDoctor(params[:doctor_id])
				render json: {}, status: :ok
			else
				render json: { errors: "Patient doesn't have this Doctor: #{params[:doctor_id]} on unit: #{params[:unit_id]}" }, status: :not_found
			end
		end
	end

	def notes
		patient_unit = current_patient.units.find_by(id: params[:unit_id])

		if patient_unit
			notes = patient_unit.notes
			render json: notes.to_json(only: [:id, :data]), status: :ok
		else
			render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
		end
	end

	def add_note
		patient_unit = current_patient.units.find_by(id: params[:unit_id])
		if patient_unit && patient_unit.addNote(params[:data])
			render json: {}, status: :ok
		else
			render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
		end
	end

	def destroy
		patient_unit = current_patient.units.find_by(id: params[:id])

		if patient_unit
			patient_unit.destroy
			render json: { }, status: :ok
		else
			render json: { errors: "Patient doesn't posses the unit: #{params[:unit_id]}" }, status: :not_found
		end
	end

	def index
		units = current_patient.units
		render json: units.to_json(only: [:id], include: {
			general_unit: { except: [] },
			doctors: { methods: [:full_name], only: [] }
		} ), status: :ok
	end

    def change_filter
        patient_unit = current_patient.units.find_by(id: params[:unit_id])
        note_filter = params[:filter]
        if note_filter && patient_unit && patient_unit.update(filter: note_filter)
            render json: {}, status: :ok
        else
            render json: { errors: "someting whent rong when updating filter" }, status: :unprocessable_entity
        end
    end

    def get_filter
        patient_unit = current_patient.units.find_by(id: params[:unit_id])
    	if patient_unit
            render json: patient_unit.filter, status: :ok
        else
            render json: { errors: "Unit not found" }, status: :unprocessable_entity
        end
    end


    def share_notes
        unit = Unit.find_by(id: params[:unit_id])
        doctors = unit.doctors.where(id: params[:doctor_ids])

        doctors.each do |doc|
            doc.share_notes(params[:unit_id], params[:note_ids])
        end

        if unit
            render json: { }, status: :ok
        else
            render json: { errors: "You do not have this unit" }, status: :not_found
        end
    end

    def doctors
    	unit = current_patient.units.find_by(id: params[:unit_id])
		if unit.present?
			doctors = unit.doctors
			render json: doctors.to_json({
				only: [:id],
				include: {
					user: {
						only: [:first_name, :last_name, :address]
					}
				}
			}), status: :ok
		else
			render json: { errors: "There is no doctor for this module or this module doesn't exist: #{params[:id]}" }, status: :not_found
		end
	end

	def get_general_unit_id
    	unit = current_patient.units.find_by(id: params[:unit_id])
		if unit
            render json: {id: unit.general_unit.id}, status: :ok
        else
            render json: { errors: "You do not have this unit" }, status: :not_found
        end
	end

private

    def permited_params
        params.require(:unit).permit(:doctor_id, :patient_id, :data, :filter)
    end


end
