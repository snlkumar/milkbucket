class ProductsController < ApplicationController
	before_action :common
	def index
		@product = Product.new		
	end

	def create
		@product = Product.new params[:product].permit!
		if @product.save
			redirect_to products_path
		else
			render 'index'
		end
		# valid = false
		# html = render_to_string(:partial => "list",:layout => false)
		# valid = true if product.save
		# render json: {valid: valid, html: html}
	end

	def edit
		@products = Product.all
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
