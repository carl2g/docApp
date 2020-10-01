class Filter < ActiveRecord::Migration[5.2]
	def change
	    add_column :general_units,  :filter,    :json, default: []
	    add_column :units,          :filter,    :json, default: []
	    add_column :notes,          :filter,    :json, default: []
	end
end
