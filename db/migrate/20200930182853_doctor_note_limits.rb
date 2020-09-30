class DoctorNoteLimits < ActiveRecord::Migration[5.2]
  def change
  	add_column :doctor_units, 	:fields_limits, :json, default: {}
  end
end
