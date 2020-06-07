class DoctorMailer < ApplicationMailer
	
	def send_message(doctor, dest, sujet, msg)
		@msg = msg
		@doc = doctor
	    mail(to: dest, subject: sujet)
  	end
end
