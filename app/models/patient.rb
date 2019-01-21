class Patient < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user
	validates 	:user_id, 	presence: true

	def self.createPatient(params)
		new_user 	= User.create(params)
		patient 	= Patient.new({user_id: new_user.id})
		if !patient.save
			patient.errors.merge!(new_user.errors)
		end
		return patient
	end

	def user
		User.find(self.user_id)
	end
end
