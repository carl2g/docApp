class CreateModulesClass < ActiveRecord::Migration[5.2]
  	def change
	  	create_table 		:generic_modules do |t|
	  		t.string 		:name
	  		t.string 		:icon
	  		t.string 		:color
	  	end
  	end
end
