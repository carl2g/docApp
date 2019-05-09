class ApplicationRecord < ActiveRecord::Base

  	self.abstract_class = true

  	def keep_attributes(attributes = [])
		self.attributes.select {|key, val| attributes.include?(key.to_sym) }
	end

	def reject_attributes(attributes = [])
		self.attributes.reject {|key, val| attributes.include?(key.to_sym) }
	end

	def to_proc
	  proc { |obj, *args| obj.send(self, *args) }
	end
end
