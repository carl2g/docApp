class NoteModelCreation < ActiveRecord::Migration[5.2]
  def change
  	change_table :general_units do |t|
  		t.json :note_model, default: []
  	end
  end
end
