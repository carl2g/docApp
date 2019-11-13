class DoctorUnit < ApplicationRecord
  belongs_to 	:doctor
  belongs_to 	:unit
  has_many 		:doctor_unit_notes
  has_many 		:notes, through: :doctor_unit_notes
end
