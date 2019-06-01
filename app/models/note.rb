class Note < ApplicationRecord

	# class field
	# =======================================
	# data: 		json text
	# =======================================

	belongs_to :i_module

	def self.generateNote(module_id, data, patient)
		gen_module = IModule.find_by(id: module_id, patient_id: patient)
		Note.new( { i_module: gen_module, created_at: DateTime.now, updated_at: DateTime.now , data: data.to_json } )
	end

end
