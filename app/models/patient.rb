class Patient < ApplicationRecord

	# class field
	# =======================================
	# user_id: 			integer
	# generic_modules_id 	integer
	# =======================================

	has_one 			:user
	has_many			:doctors
	has_many 			:notes
	has_and_belongs_to_many :generic_modules

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

	def addModule(mod)
		return false if mod.nil? || self.has_module?(mod)
		self.generic_modules << mod
		self.save
	end

	def removeModule(mod)
		return false if mod.nil?
		self.generic_modules.delete(mod)
		self.save
	end

	def addDoctor(doctor)
		return false if doctor.nil?
		self.doctors << doctor
		self.save
	end

	def has_module?(mod)
		if self.generic_modules.include?(mod)
			self.errors.add(:modules, 'is already added to your list.')
			return true
		end
		return false
	end

	def user
		User.find(self.user_id)
	end

end
