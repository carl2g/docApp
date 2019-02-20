class Note < ApplicationRecord

	# class field
	# =======================================
	# data: 		json text
	# =======================================

	belongs_to :patient

	def self.generateNote(module_id, data, patient)
		gen_module = GModule.find_by(id: module_id)
		Note.new( { g_module: gen_module, patient: patient, data: data.to_json } )
	end

end
