class Doctor < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user
	has_many 	:patients
	validates 	:user_id, 	presence: true

	def self.createDoctor(params)
		new_user 	= User.generate_user(params)
		doctor 	= Doctor.new({user_id: new_user.id})
		if !doctor.save
			doctor.errors.clear
			doctor.errors.merge!(new_user.errors)
		end
		return doctor
	end

	def user
		User.find(self.user_id)
	end

end
