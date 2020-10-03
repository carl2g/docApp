class DoctorUnit < ApplicationRecord
  belongs_to 	:doctor
  belongs_to 	:unit
  has_many 		:doctor_unit_notes
  has_many 		:notes, through: :doctor_unit_notes

  # after_save :check_note_limits, if: -> { fields_limits_changed? }

  # If the doctor change his limites it applies to previous notes
  # def check_note_limits
  # end

end
