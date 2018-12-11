class User < ApplicationRecord
	# Model field
	# =======================================
	# first_name: 		string
	# last_name: 		string
	# password: 		string
	# phone_number: 	string
	# email: 			string
	# token: 			string
	# last_connection: 	Time
	# =======================================

	include ActiveModel::Serializers::JSON

	after_create :generate_token

	validates :first_name, 	presence: true
	validates :last_name, 	presence: true
	validates :email, 		presence: true, uniqueness: true
	validates :password, 	presence: true, length: { minimum: 6 }
	validates :login_token, uniqueness: true


	def attributes
    	{  	first_name: 	nil,
    		last_name: 		nil,
    		password: 		nil,
    		phone_number: 	nil,
    		email: 			nil
    	}
  	end

  	def generate_token
  		puts "LOGIN?"
  		loop do
      		self.login_token = SecureRandom.urlsafe_base64(32, false)
      		break if self.save
    	end
  	end

  	def self.authenticate(email, password)
  		user = User.where(password: password, email: email).first
  		user.generate_token if user.present?
		return user
  	end
end
