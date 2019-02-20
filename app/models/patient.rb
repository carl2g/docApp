class Patient < ApplicationRecord

	# class field
	# =======================================
	# user_id: 			integer
	# g_modules_id 	integer
	# =======================================

	has_one 			:user
	has_many 			:i_modules
	has_many 			:g_modules, through: :i_modules
	has_many			:doctors, 	through: :i_modules
	has_many 			:notes

	validates 	:user_id, 	presence: true


	def self.createPatient(params)
		new_user 	= User.generate_user(params)
		patient 	= Patient.new({user_id: new_user.id})
		unless patient.save
			patient.errors.clear
			patient.errors.merge!(new_user.errors)
			new_user.destroy
		end
		return patient
	end

	def addModule(mod)
		return false if mod.nil? || self.has_module?(mod)
		self.i_modules << IModule.new({g_module: mod})
		self.save
	end

	def removeModule(mod)
		return false if mod.nil?
		self.i_modules.g_modules.find_by(g_module: mod).delete(mod)
		self.save
	end

	def removeDoctor(doctor, g_module)
		return false if doctor.nil? || g_module.nil?
		mod = self.i_modules.find_by(g_module: g_module)
		if mod.nil?
			return false
		else
			mod.doctor = nil
		end
		mod.save
	end

	def addDoctor(doctor, g_module)
		return false if doctor.nil? || g_module.nil?
		mod = self.i_modules.find_by(g_module: g_module)
		if mod.nil?
			self.i_modules << IModule.new({g_module: g_module, doctor: doctor})
		else
			mod.doctor = doctor
		end
		self.save
	end

	def has_module?(mod)
		if self.g_modules.include?(mod)
			self.errors.add(:modules, 'is already added to your list.')
			return true
		end
		return false
	end

	def user
		User.find(self.user_id)
	end

end
