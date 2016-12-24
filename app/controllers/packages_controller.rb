class PackagesController < ApplicationController
	def new
		@package = Package.new
	end
	def create
		@package = Package.new params[:package].permit!
		if @package.save
			redirect_to new_package_path
		else
			render 'new'
		end
	end
end