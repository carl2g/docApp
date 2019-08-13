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
	has_many	:notes
	has_many	:doctor_units
	has_many	:doctor, through: :doctor_units

	# Remove a doctor for a module
	def removeDoctor(doctor_id)
		doc = self.doctors.find_by(id: doctor_id)
		return doc.nil? ? false : doc.destroy
		
	end

	# Add a doctor for a module
	def addDoctor(doctor_id)
		doctor = Doctor.find_by(id: doctor_id)
		if self.doctors.find_by(id: doctor_id)
			return false
		else
			self.doctors << doctor
		end
		return self.save
	end

	def addNote(data)
		filter = self.filter || self.general_unit.filter
		self.notes << Note.create({ data: data.to_json, filter: filter })
		self.save
	end
end
