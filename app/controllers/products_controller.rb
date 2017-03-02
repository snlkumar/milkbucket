class ProductsController < ApplicationController
	before_action :common
	def index
		@product = Product.new
		@category = Category.all.select {|x| x.name != 'Milk'}
		Package.all.each { |p|
			@product.liters.build(package_id: p.id)
		} if params[:category]
	end

	def create	
	   debugger	
		@product = Product.new params[:product].permit!		
		if @product.save
			redirect_to products_path
		else
			render 'index'
		end		
	end

	def edit
		@products = Product.all
		@category = Category.all
		render 'index'
	end

	def update	
		if @product.update_attributes params[:product].permit!
			redirect_to products_path
		else
			render 'index'
		end			
	end

	def destroy
		@product.destroy
		redirect_to products_path
	end

	private
	def common		
		@products = Product.all
		if %w(edit update destroy).include? params[:action]
			@product = Product.find params[:id]
		end
	end
end
