class Api::Doctors::DoctorUnitsController < Api::Doctors::ApplicationController

	def set_fields_limits
		id = params[:doctor_unit_id]
		fileds_limits = params[:fileds_limits]
		doc_unit = DoctorUnit.find_by(id: id)

		if doc_unit && fileds_limits
			doc_unit.update(fields_limits: fileds_limits)
			render json: doc_unit.fields_limits, status: :ok
		else
			render json: { :errors => "Doctor Unit id #{id} not found" }, status: :not_found
		end
	end

	def get_fields_limits
		id = params[:doctor_unit_id]
		doc_unit = DoctorUnit.find_by(id: id)

		if doc_unit
			render json: doc_unit.fields_limits, status: :ok
		else
			render json: { errors: "Doctor Unit id: #{id} not found" }, status: :not_found
		end
	end

	# def get_limitis_field
	# end
end
