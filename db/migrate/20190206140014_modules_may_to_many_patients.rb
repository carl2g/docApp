class ModulesMayToManyPatients < ActiveRecord::Migration[5.2]

  	def change
  		create_table :generic_modules_patients, id: false do |t|
		      t.belongs_to :patient, index: true
		      t.belongs_to :generic_module, index: true
    		end
  	end

end
