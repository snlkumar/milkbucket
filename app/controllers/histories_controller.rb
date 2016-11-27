class HistoriesController < ApplicationController
	def new
		@history = History.new
		@milk = Product.milk
		@dahi = Product.dahi
	end

	def create
		debugger
	end
end
