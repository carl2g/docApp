class Doctor < ApplicationRecord

	include ActiveModel::Serializers::JSON

	has_one 	:user, 	as: :user_type

	def self.createDoctor(params)
		new_user 	= User.new(params)
		doctor 	= Doctor.create
		new_user.user_type = doctor
		if new_user.save
			doctor.update({ user: new_user })
		else
			doctor.destroy
			return new_user
		end
		return doctor
	end

  	def self.authenticate(email, password)
  		user = User.authenticate(email, password)
  		if user
  			return user.user_type
  		end
  		return nil
  	end

end
