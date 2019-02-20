class IModule < ApplicationRecord
	belongs_to 	:patient
	belongs_to 	:doctor
	belongs_to 	:g_module
	has_many 	:notes
end
