class CreateUnits < ActiveRecord::Migration[5.2]

     	def change
          	create_table :units do |t|
                	t.belongs_to 	:patient, index: true
                 	t.belongs_to 	:general_unit, index: true
                 	t.integer 		:doctor_id, index: true
          	end
      end

end
