class Patient < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user
	has_many	:doctors
	validates 	:user_id, 	presence: true

	def self.createPatient(params)
		new_user 	= User.generate_user(params)
		patient 	= Patient.new({user_id: new_user.id})
		if !patient.save
			patient.errors.clear
			patient.errors.merge!(new_user.errors)
			new_user.destroy
		end
		return patient
	end

	def addDoctor(doctor_id)
		self.doctors_id << doctor_id
		self.save
	end

	def addModule(modul)
		return false if modul.nil
		self.d_modules << modul
		self.save
	end

	def user
		User.find(self.user_id)
	end
end
