class Unit < ApplicationRecord

	# class Unit
	# =======================================
	# patient: 		obj
	# doctor: 		obj
	# general_unit: 	obj
	# notes: 		obj collection
	# =======================================

	belongs_to	:patient
	belongs_to	:general_unit
	has_many		:notes
	has_many		:doctor_units
	has_many		:doctor, through: :doctor_units

	# Remove a doctor for a module
	def removeDoctor(doctor_id)
		d = DoctorUnit.find_by(doctor_id: doctor_id, unit_id: self.id)

		return false if d.nil?
		d.destroy
		return true
	end

	# Add a doctor for a module
	def addDoctor(doctor_id)
		doctor = GeneralUnitDoctor.find_by(doctor_id: doctor_id, general_unit_id: self.general_unit_id)
		return false if doctor.nil?
		doc = DoctorUnit.find_by(doctor_id: doctor_id, unit_id: self.id)
		return false if doc.present?
		d = DoctorUnit.new(unit_id: self.id, doctor_id: doctor_id)
		return d.save
	end

	def addNote(data)
		filter = self.filter || self.general_unit.filter
		self.notes << Note.create({ data: data.to_json, filter: filter })
		self.save
	end
end
