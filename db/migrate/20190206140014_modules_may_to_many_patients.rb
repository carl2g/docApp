class ModulesMayToManyPatients < ActiveRecord::Migration[5.2]

     	def change
          	create_table :i_modules, id: false do |t|
                	t.belongs_to :patient, index: true
                 	t.belongs_to :g_module, index: true
                 	t.belongs_to :doctor, index: true, optional: true
          	end
      end

end
