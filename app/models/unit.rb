class Unit < ApplicationRecord

	# class Unit
	# =======================================
	# patient: 		obj
	# doctor: 		obj
	# general_unit: obj
	# notes: 		obj collection
	# =======================================

	belongs_to	:patient
	belongs_to	:general_unit
	has_many	:notes
	has_many	:doctor_units
	has_many	:doctors, through: :doctor_units

	after_create :set_filter

	def set_filter
		self.update(filter: self.general_unit.filter)
	end

	# Remove a doctor for a unit
	def removeDoctor(doctor_id)
		doc = self.doctors.find_by(id: doctor_id)
		return false if doc.nil?
		return self.doctors.delete(doc).nil? ? false : self.save
	end

	# Add a doctor for a unit
	def addDoctor(doctor_id)
		doctor = Doctor.find_by(id: doctor_id)
		return false if self.hasDoctor?(doctor_id) || doctor.nil?
		self.doctors << doctor
		return self.save
	end

	def hasDoctor?(doc_id)
		return self.doctor_ids.include?(doc_id)
	end

	def addNote(data)
		filter = self.filter || self.general_unit.filter
		self.notes << Note.create({ data: data.to_json, filter: filter })
		return self.save
	end
end