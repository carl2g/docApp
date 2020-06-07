class Api::MailController < ApplicationController

	before_action :is_doctor?, only: [:send_mail_from_doctor]

	def send_mail_from_doctor
		dest = params[:destinataire]
		sujet = params[:sujet]
		msg = params[:message]
		puts "#{msg} #{sujet} #{dest}"
		DoctorMailer.send_message(current_doctor, dest, sujet, msg).deliver_later
		render json: { success: "ok" }, status: :ok
	end

end
