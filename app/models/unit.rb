class Unit < ApplicationRecord
	belongs_to 	:patient
	belongs_to 	:doctor, 	optional: true
	belongs_to 	:general_unit
	has_many 	:notes

	# Remove a doctor for a module
	def removeDoctor
		self.update(doctor: nil)
	end

	# Add a doctor for a module
	def addDoctor(doctor_id)
		doctor = Doctor.find_by(id: doctor_id)
		return false if doctor.nil?
		self.update(doctor_id: doctor_id)
	end

	def addNote(data)
		self.notes << Note.create({ data: data.to_json })
		self.save
	end
end
