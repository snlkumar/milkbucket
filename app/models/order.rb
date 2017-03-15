class Order < ActiveRecord::Base
	has_many :order_items, dependent: :destroy
	has_many :items, through: :order_items
	belongs_to :client	
	accepts_nested_attributes_for :order_items

	def calculate_price
		order_items.map(&:price).sum
	end
end
