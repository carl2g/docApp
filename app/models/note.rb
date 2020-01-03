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
		data_val = self.attributes["data"].is_a?(Hash) ? self.attributes["data"].to_s : self.attributes["data"]
		return data_val.gsub('=>', ':')
	end
end
