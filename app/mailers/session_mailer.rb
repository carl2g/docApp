class SessionMailer < ApplicationMailer

	def patient_email_confirmation(params, token)
		email_dest = params[:email]
		@patient_name = params[:name]
		@token = token
	    mail(to: email_dest, subject: 'ChronoSymple email confirmation')
	end

end
