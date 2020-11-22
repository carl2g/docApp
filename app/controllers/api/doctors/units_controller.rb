class Api::Doctors::UnitsController < Api::Doctors::ApplicationController

	def set_fields_limits
		id = params[:unit_id]
		fields_limits = params[:fields_limits]
		doc_unit = current_doctor.doctor_units.find_by(unit_id: id)

		if doc_unit && fields_limits
			doc_unit.update(fields_limits: fields_limits)
			render json: doc_unit.fields_limits, status: :ok
		else
			render json: { :errors => "Doctor Unit id #{id} not found" }, status: :not_found
		end
	end

	def get_fields_limits
		id = params[:unit_id]
		doc_unit = current_doctor.doctor_units.find_by(unit_id: id)

		if doc_unit
			render json: doc_unit.fields_limits, status: :ok
		else
			render json: { errors: "Doctor Unit id: #{id} not found" }, status: :not_found
		end
	end

end
