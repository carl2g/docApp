class ModulesMayToManyPatients < ActiveRecord::Migration[5.2]

  	def change
  		create_table :d_modules_patients, id: false do |t|
		      t.belongs_to :patient, index: true
		      t.belongs_to :d_module, index: true
    		end
  	end

end
