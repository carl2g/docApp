class CreateGeneralUnitsClass < ActiveRecord::Migration[5.2]
  	def up
	  	create_table 		:general_units do |t|
	  		t.string 		:name
	  		t.string 		:icon
	  		t.string 		:color
	  	end
		GeneralUnit.create!({name: 'diabetes',  color: 'blue',  icon: 'to be defined'})
  	end
end
