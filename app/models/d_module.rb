class DModule < ApplicationRecord
	# class field
	# =======================================
	# name: 		string
	# color: 		string
	# icon: 		string
	# =======================================

	has_and_belongs_to_many 	:patients

end
