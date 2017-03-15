class Product < ActiveRecord::Base
	belongs_to :category
	has_many :packages, through: :liters
	has_many :liters
	accepts_nested_attributes_for :liters, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :packages
	class << self
		def milk
			Category.where(name: 'Milk').first.products.map(&:milk_response)
		end

		def dahi
			Category.where(name: 'Dahi').first.products.map(&:dahi_response)
		end
	end

	def get_price(name)		
		pkgid= Package.where(name: name).first.id
		self.liters.detect {|x| x.package_id == pkgid}.try(:price)
	end

	def milk_response		
		{name: name, category: 'Milk', '1/2ltr' => get_price('1/2ltr'), '1ltr' => get_price('1ltr'), '6ltr' => get_price('6ltr')}
	end

	def dahi_response
		{name: name, category: 'Dahi', price: price}
	end
end
