class ApplicationRecord < ActiveRecord::Base

  	self.abstract_class = true

	def to_proc
	  proc { |obj, *args| obj.send(self, *args) }
	end
end
