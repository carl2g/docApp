class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|

    	t.belongs_to :unit, index: true
    	t.json :data

      t.timestamps
    end
  end
end
