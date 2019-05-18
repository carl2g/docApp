class Note < ApplicationRecord

	# class field
	# =======================================
	# data: 		json text
	# =======================================

	belongs_to :i_module

	def self.addNote(module_id, data, patient)
		imodule = IModule.find_by(g_module: module_id, patient: patient)
		return false if imodule.nil?
		imodule.notes << Note.create({ data: data.to_json })
	end

end
