class Diabete < ApplicationRecord

	#validates :module_id,		presence :true, :uniqueness: true
	validates :glucose			presence :true, numericality: true, allow_nil: true
	validates :carbs			numericality: true, allow_nil: true
	validates :meal_type
	validates :meal_description
	validates :insulin_food			numericality: true, allow_nil: true
	validates :insulin_corr			numericality: true, allow_nil: true
	validates :insulin_long_act		numericality: true, allow_nil: true
	validates :activity_type		presence :true
	validates :activity_description
	validates :notes
	validates :a1c				numericality: true, allow_nil: true
	validates :weight			numericality: true, allow_nil: true
	validates :blood_pressure		numericality: true, allow_nil: true
	validates :ketones			numericality: true, allow_nil: true

	def attibutes {
		glucose:		nil,
		carbs:			nil,
		meal_type:		nil,
		meal_description:	nil,
		insulin_food:		nil,
		insulin_corr:		nil,
		insulin_long_act:	nil,
		activity_type:		nil,
		activity_description:	nil,
		notes:			nil,
		a1c:			nil,
		weight:			nil,
		blood_pressure:		nil,
		ketones:		nil
	}end

	def report(params)
		self.glucose = params[:glucose]
		self.activity_type = params[:activity_type]
		self.carbs = params[:carbs]
		self.meal_type = params[:meal_type]
		self.meal_description = params[:meal_description]
		self.insulin_food = params[:insulin_food]
		self.insulin_corr = params[:insulin_corr]
		self.insulin_long_act = params[:insulin_long_act]
		self.activity_description = params[:activity_description]
		self.notes = params[:notes]
		self.a1c = params[:a1c]
		self.weight = params[:weight]
		self.blood_pressure = params[:blood_pressure]
		self.ketones = params[:ketones]
	end
end