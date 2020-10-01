class CreateModelNote < ActiveRecord::Migration[5.2]
   def change
      add_column :general_units, :note_model, :json, default: []
   end
end
