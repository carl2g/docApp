class CreatingStatusPatientModel < ActiveRecord::Migration[5.2]
 	def change
		create_table		:user_status do |t|
			t.index 		:user_id
			t.integer 		:status, 		default: 0
  		end
  	end
end
