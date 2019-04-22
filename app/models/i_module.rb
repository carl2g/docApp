class IModule < ApplicationRecord
	belongs_to 	:patient
	belongs_to 	:doctor, 	optional: true
	belongs_to 	:g_module
	has_many 	:notes

	# Remove a doctor for a module
	def removeDoctor
		self.doctor = nil
		self.save
	end

	# Add a doctor for a module
	def addDoctor(doctor_id)
		doctor = Doctor.find_by(id: doctor_id)
		return false if doctor.nil?
		self.doctor = doctor
		self.save
	end
end
