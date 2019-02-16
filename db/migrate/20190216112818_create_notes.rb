class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|

    	t.belongs_to :patient, 		index: true
    	t.belongs_to :generic_module, index: true

    	t.text 	:data

      t.timestamps
    end
  end
end
