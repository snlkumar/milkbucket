class Package < ActiveRecord::Base
	has_many :products, through: :liters
	has_many :liters
end
