class User < ApplicationRecord
  rolify

	# class field
	# =======================================
	# first_name: 		 string
	# last_name: 		   string
	# password: 		   string
	# phone_number:    string
	# email: 			     string
	# login_token:     string
	# last_connection: Time
	# =======================================

	after_create :generate_token
	before_create :cipher_password
	before_update :cipher_password, if: -> { password_changed? }
	after_create :assign_default_role

	validates :first_name,	presence: true
	validates :last_name,		presence: true
	validates :email,				presence: true, uniqueness: true
	validates :password,		presence: true, length: { minimum: 6 }
	validates	:birthdate,		presence: true
	validates	:civility,		presence: true
	validates	:picture,			presence: false
	validates :address,			presence: false
	validates :login_token,	uniqueness: true, if: -> { login_token.present? }

	  def assign_default_role
	    self.add_role(:normal)
	  end

	def cipher_password
		return false if !self.valid?
		self.password = BCrypt::Password.create(self.password)
	end

  	def generate_token
  		loop do
      		self.login_token = SecureRandom.urlsafe_base64(32, false)
      		break if self.save
    	end
  	end

  	def self.generate_user(params)
  		new_user = User.new(params)
  		if new_user.save
  			new_user.update({ password: new_user.password })
  		end
  		return new_user
  	end

  	def self.authenticate(email, password)
			user = User.find_by(email: email)
  		if user.present? && BCrypt::Password.new(user.password) == password
				user.generate_token
		else
  			return nil
  		end
		  return user
		end

		def is_password_valid(pwd)
			if BCrypt::Password.new(self.password) != pwd
				return false;
			end
			return true;
		end

    def full_name
      return first_name + " " + last_name
    end

end
