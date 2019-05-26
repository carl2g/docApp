class CreateGeneralUnitsClass < ActiveRecord::Migration[5.2]
  	def change
	  	create_table 		:general_units do |t|
	  		t.string 		:name
	  		t.string 		:icon
	  		t.string 		:color
	  	end
  	end
end
