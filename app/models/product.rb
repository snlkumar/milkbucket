class Product < ActiveRecord::Base
	belongs_to :category
	class << self
		def milk
			Category.where(name: 'Milk').first.products
		end

		def dahi
			Category.where(name: 'Dahi').first.products
		end
	end
end
