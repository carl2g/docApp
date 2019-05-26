class Filter < ActiveRecord::Migration[5.2]
  def change
  	add_column :general_units, 	:filter, 		:string
  	add_column :general_units, 	:available_info,	:string
  	add_column :units, 		:filter, 		:string
  	add_column :notes, 		:filter, 		:string
  end
end
