class Note < ApplicationRecord

	# class field
	# =======================================
	# data: 		json string
	# filter: 		json sting
	# =======================================

	belongs_to 	:unit
	has_many 	:doctor_unit_notes, dependent: :destroy
	has_many    :doctor_units, through: :doctor_unit_notes
	has_many 	:doctors, through: :doctor_units
end
