class AddDoctorToPatient < ActiveRecord::Migration[5.2]
  def change
    change_table :patients do |t|
      t.belongs_to :doctors, index: true
    end
  end
end
