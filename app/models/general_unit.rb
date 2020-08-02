class GeneralUnit < ApplicationRecord
	# class field
	# =======================================
	# name: 		string
	# color: 		string
	# icon: 		string
	# filter: 		string
	# data_field: 	string
	# note_model: 	string
	# =======================================

	has_many	:units
	has_many	:patients, through: :units
	has_many	:general_unit_doctors
	has_many	:doctors, through: :general_unit_doctors

end
