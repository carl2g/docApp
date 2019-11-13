class Note < ApplicationRecord

	# class field
	# =======================================
	# data: 		json string
	# filter: 		json sting
	# =======================================

	belongs_to 	:unit
	has_many 	:doctor_unit_notes
	has_many    :doctor_units, through: :doctor_unit_notes

	def data
		self.attributes["data"].gsub('=>', ':')
	end

end
