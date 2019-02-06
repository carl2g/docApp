class CreateModulesClass < ActiveRecord::Migration[5.2]
  	def change
	  	create_table 		:d_modules do |t|
	  		t.string 		:name
	  		t.string 		:icon
	  		t.string 		:color
	  		t.belongs_to 	:patient, index: true
	  	end
  	end
end
