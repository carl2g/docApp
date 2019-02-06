class Patient < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_and_belongs_to_many 	:d_modules

	has_one 	:user
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

	def addModule(modul)
		return false if modul.nil?
		self.d_modules << modul
		self.save
	end

	def user
		User.find(self.user_id)
	end
end
