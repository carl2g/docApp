class NotesDoctors < ActiveRecord::Migration[5.2]
  def change
    remove_column :notes,          :filter,    :json, default: {}
  	create_table :doctor_unit_notes do |t|
      t.belongs_to :note, index: true
      t.belongs_to :doctor_unit, index: true
      t.json 	   :filter, default: {}
    end
  end
end
