class Note < ApplicationRecord

	# class field
	# =======================================
	# data: 		json text
	# =======================================

	belongs_to :patient
	belongs_to :generic_module

	validates :patient,		presence: true
	validates :generic_module,	presence: true

	def self.generateNote(module_id, data, patient)
		gen_module = GenericModule.find_by(id: module_id)
		Note.new( { generic_module: gen_module, patient: patient, data: data } )
	end

end
