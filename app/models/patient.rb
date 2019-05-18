class Patient < ApplicationRecord

	# class field
	# =======================================
	# user_id: 		integer
	# g_modules_id 	integer
	# =======================================

	# Association objects
	has_one 	:user
	has_many 	:i_modules
	has_many 	:g_modules, through: :i_modules
	has_many	:doctors, 	through: :i_modules

	# Delegations
	delegate 	:notes, to: :notes
	delegate 	:login_token, :email, :first_name, :last_name, to: :user

	# Validations
	validates 	:user_id, presence: true

	# Get all existing notes
	def notes
		self.i_modules.sum { |i| i.notes }
	end

	# Init  and create patient
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

	# Add a Module to a user
	def addModule(mod_id)
		return false if mod_id.nil? || self.has_module?(mod_id)
		self.i_modules << IModule.new({g_module_id: mod_id})
		self.save
	end

	# Remove a Module to a user
	def removeModule(mod_id)
		imod = self.i_modules.find_by(g_module_id: mod_id)
		return false if imod.nil?
		imod.destroy
		self.save
	end

	# Check if patient have module
	def has_module?(mod_id)
		mod = GModule.find_by(id: mod_id)
		if self.g_modules.include?(mod)
			self.errors.add(:modules, 'is already added to your list.')
			return true
		end
		return false
	end

	#
	def getDoctorsInfo
		selected_attr = [:id, :email, :first_name, :last_name]
		mods = self.i_modules.where.not(doctor: nil)
		infos = mods.map do |m|
			mod_info = m.g_module.attributes.slice('name', 'id')
			{
				doctor: m.doctor.keep_attributes(selected_attr),
				module: mod_info
			}
		end
		return infos
	end

	# Fetch user associated with patient
	def user
		User.find(self.user_id)
	end

	# Remove a doctor for a module
	def removeDoctor(doctor_id, g_module_id)
		i_mod = self.i_modules.find_by(g_module_id: g_module_id)
		if i_mod.nil?
			self.errors.add(:module_error, 'you do not have this module.')
			return false
		end
		return i_mod.removeDoctor
	end

	# Add a doctor for a module
	def addDoctor(doctor_id, g_module_id)
		i_mod = self.i_modules.find_by(g_module_id: g_module_id)
		if i_mod.nil?
			self.errors.add(:module_error, 'you do not have this module.')
			return false
		end
		return i_mod.addDoctor(doctor_id)
	end

end
