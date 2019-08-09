class GeneralUnit < ApplicationRecord
	# class field
	# =======================================
	# name: 		string
	# color: 		string
	# icon: 		string
	# filter: 		string
	# data_field: 	string
	# =======================================

	has_many	:units
	has_many	:doctors, 	through: :units
	has_many	:patients, 	through: :units

end
