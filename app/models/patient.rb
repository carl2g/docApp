class Patient < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user, as: :user_type

	def self.createPatient(params)
		new_user 	= User.new(params)
		patient 	= Patient.create
		new_user.user_type = patient
		if new_user.save
			patient.update({ user: new_user })
		else
			patient.destroy
			return new_user
		end
		return patient
	end

end
