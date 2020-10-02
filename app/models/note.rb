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
	after_save 	:update_doctor_notes_check

	def update_doctor_notes_check
		self.doctor_unit_notes.each do |doc_unit_note|
			doc_unit_note.check_limits
		end
	end
end
