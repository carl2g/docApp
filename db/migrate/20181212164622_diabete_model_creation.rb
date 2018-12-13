class DiabeteModelCreation < ActiveRecord::Migration[5.2]
	def change
		create_table		:diabetes do |t|
			t.belongs_to	:modules
			t.float		:glucose
			t.integer		:carbs
			t.string		:meal_type
			t.string		:meal_description
			t.float		:insulin_food
			t.float		:insulin_corr
			t.string		:activity_type
			t.string		:activity_description
			t.string		:notes
			t.float		:a1c
			t.float		:weight
			t.timestamps
		end
	end
end
