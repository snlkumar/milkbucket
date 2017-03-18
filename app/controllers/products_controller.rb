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
		@product = Product.new params[:product].permit!		
		if @product.save
			redirect_to products_path
		else
			render 'index'
		end		
	end

	def edit		
		@category = Category.all.select {|x| x.name != 'Milk'}
		render 'index'
	end

	def update
		if @product.update_attributes params[:product].permit!
			path = params[:category] ? products_path(category: 'Milk') : products_path
			redirect_to path
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
		@products = params[:category] ? Product.milk_products : Product.allwm
		if %w(edit update destroy).include? params[:action]
			@product = Product.find params[:id]
		end
	end
end
