class Api::Patients::UnitsController < ApplicationController

	before_action :authenticate_user

	def add_doctor
		patient_unit = current_patient.units.find_by(id: params[:unit_id])
		if patient_unit && patient_unit.addDoctor(params[:doctor_id])
			render json: {}, status: :ok
		else
			render json: { errors: "You do not possessed this unit" }, status: :not_found
		end
	end

	def remove_doctor
		patient_unit = current_patient.units.find_by(id: params[:unit_id])
		if patient_unit && patient_unit.removeDoctor
			render json: {}, status: :ok
		else
			render json: { errors: "You do not possessed this unit" }, status: :not_found
		end
	end

	def create_note
		unit = current_patient.units.find_by(id: params[:unit_id])
		if unit && unit.addNote(params[:data])
			render json: {}, status: :ok
		else
			render json: { errors: "You do not have this unit" }, status: :not_found
		end
	end

	def notes
		patient_unit = current_patient.units.find_by(id: params[:unit_id])
		notes = patient_unit.notes
		render json: notes.to_json(only: [:id, :data]), status: :ok
	end

	def add_note
		patient_unit = current_patient.units.find_by(id: params[:unit_id])
		if patient_unit && patient_unit.addNote(params[:data])
			render json: {}, status: :ok
		else
			render json: { errors: "You do not have this unit" }, status: :not_found
		end

	end

	def destroy
		patient_unit = current_patient.units.find_by(id: params[:id])
		if patient_unit
			render json: { }, status: :ok
		else
			render json: { errors: "You do not have this unit" }, status: :not_found
		end
	end

	def index
		units = current_patient.units
		render json: units.to_json(only: [:id], include: {
			general_unit: { except: [:id] },
			doctor: { methods: [:full_name], only: [] }
		} ), status: :ok
	end

private

	def permited_params
		params.require(:unit).permit(:doctor_id, :patient_id)
	end


end
