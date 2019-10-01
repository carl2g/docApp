class DoctorUnitNote < ApplicationRecord
	belongs_to :note
	belongs_to :doctor_unit
end
