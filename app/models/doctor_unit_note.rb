class DoctorUnitNote < ApplicationRecord
	belongs_to :note
	belongs_to :doctor_unit
	has_one :unit, through: :doctor_unit
	has_one :doctor, through: :doctor_unit
	has_one :patient, through: :unit
end
