class DoctorMailer < ApplicationMailer
	
	def send_message(doctor, dest, sujet, msg)
		@msg = msg
		@doc = doctor
	    mail(to: dest, subject: sujet)
  	end

  	def send_notification_limit_exceed(doctor, user, unit, note)
		@doctor = doctor
  		@user = user
		@unit = unit
		@note = note
	    mail(to: doctor.email, subject: "Excess values patient #{user.last_name} #{user.first_name}")
  	end
end
