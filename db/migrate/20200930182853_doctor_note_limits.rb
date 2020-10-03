class DoctorNoteLimits < ActiveRecord::Migration[5.2]
  def change
  	add_column :doctor_units, 	:fields_limits, :json, default: {}
  	add_column	:doctor_unit_notes,  :note_state, :string
  end
end
