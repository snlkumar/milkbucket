class CategoriesController < ApplicationController
	def new
		@category = Category.new
	end
	def create
		@category = Category.new params[:category].permit!
		if @category.save
			redirect_to products_path
		else
			render 'new'
		end
	end
	 
end
