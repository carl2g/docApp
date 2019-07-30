class CreateDoctorUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_units do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :unit, index: true
    end

    remove_column :units, :doctor_id
  end
end
