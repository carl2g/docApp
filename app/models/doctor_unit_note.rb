class DoctorUnitNote < ApplicationRecord
	belongs_to :note
	belongs_to :doctor_unit
	has_one :unit, through: :doctor_unit
	has_one :doctor, through: :doctor_unit
	has_one :patient, through: :unit

	after_create_commit :check_limits

	def filter_note_data
		return self.note.data.to_json(self.filter.symbolize_keys)
	end

	def assert_send_mail(send_email)
		return if !send_email
		doctor = self.doctor.user
		user = self.patient.user
		unit = self.unit
		note = self.note
		DoctorMailer.send_notification_limit_exceed(doctor, user, unit, note).deliver_later
	end

	def operation_on_limits(value, limits)
		limits.each do |op, limit|
			limit = limit.to_i
			case op
			when "min_limit"
				assert_send_mail(value < limit)
			when "max_limit"
				assert_send_mail(value > limit)
			else
			end
		end
	end

	def check_limits
		available_fileds = self.doctor_unit.unit.general_unit.filter["only"]
		self.doctor_unit.fields_limits.each do |filed, limits|
			self.note.data.each do |key, val|
				if key == filed
					operation_on_limits(val.to_i, limits)
				end
			end
		end
	end
end
