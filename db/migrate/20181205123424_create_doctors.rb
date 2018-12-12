class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
	
	create_table 		:users do |t|
		t.string 		:first_name
	 	t.string      	:last_name
		t.string 		:email
	  	t.string  		:phone_number
		t.string 		:password
		t.string 		:login_token
		t.references 	:user_type, 	polymorphic: true, 	index: true
		t.time 			:last_connection
		t.timestamps
	end

	create_table 		:doctors do |t|
		# t.belongs_to  	:users
	end

	create_table 		:patients do |t|
		# t.belongs_to  	:users
	end

	create_table 		:modules do |t|
		t.string 		:name
		t.belongs_to	:patient
		t.timestamps
	end

	create_table 		:diabets do |t|
		t.belongs_to 	:modules
		t.integer 		:insuline_lvl
		t.string 		:state
		t.timestamps
	end

  end
end
