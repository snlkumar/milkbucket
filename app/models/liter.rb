class Liter < ActiveRecord::Base
	belongs_to :product
	belongs_to :package
end
