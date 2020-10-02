class DoctorUnitNote < ApplicationRecord
	include AASM

	belongs_to :note
	belongs_to :doctor_unit
	has_one :unit, through: :doctor_unit
	has_one :doctor, through: :doctor_unit
	has_one :patient, through: :unit

	after_save :check_limits

	aasm column: :note_state do
		error_on_all_events { }
    	state :normal, initial: true
    	state :anomali

    	event :anomali_detected do
	      transitions from: [:normal, :anomali], to: :anomali, if: :same_state?
	    end

	    event :return_to_normal do
	      transitions from: [:normal, :anomali], to: :normal, if: :same_state?
	    end
    end

    def same_state?
    	return !(self.note_state.to_sym == self.aasm.to_state.to_sym)
    end

	def data
		return self.note.data.to_json(self.filter.symbolize_keys)
	end

	def assert_send_mail(exceed)
		return false if !exceed
		if self.normal?
			self.anomali_detected!
			doctor = self.doctor.user
			user = self.patient.user
			unit = self.unit
			note = self.note
			DoctorMailer.send_notification_limit_exceed(doctor, user, unit, note).deliver_later
		end
		return true
	end

	def operation_on_limits(value, limits)
		mail_send = false
		limits.each do |op, limit|
			limit = limit.to_f
			case op
			when "min_limit"
				mail_send |= assert_send_mail(value < limit)
			when "max_limit"
				mail_send |= assert_send_mail(value > limit)
			else
			end
		end
		return mail_send
	end


	# This function will be called when the class is modify and when a note is modify
	# This function can be called twice in 1 action
	def check_limits
		self.doctor_unit.fields_limits.each do |field, limits|
			self.note.data.each do |key, val|
				if key == field
					return if operation_on_limits(val.to_f, limits)
				end
			end
		end
		self.return_to_normal!
	end

end
