class Patient < ApplicationRecord

	# class field
	# =======================================
	# user_id: 		integer
	# d_modules_id 	integer
	# =======================================

	include ActiveModel::Serializers::JSON

	has_and_belongs_to_many 	:d_modules

	has_one 	:user
	validates 	:user_id, 		presence: true

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

	def addModule(mod)
		return false if mod.nil? || self.has_module?(mod)
		self.d_modules << mod
		self.save
	end

	def removeModule(mod)
		return false if mod.nil?
		self.d_modules.delete(mod)
		self.save
	end

	def has_module?(mod)
		if self.d_modules.include?(mod)
			self.errors.add(:modules, 'is already added to your list.')
			return true
		end
		return false
	end

	def user
		User.find(self.user_id)
	end

end
