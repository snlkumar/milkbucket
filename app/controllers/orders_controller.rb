class OrdersController < ApplicationController
	before_action :client, only: [:edit, :update, :create]
	def new
	end

	def create
		@order=Order.new params[:order].permit!
		@order.save
		redirect_to routines_client_path(@client)
	end

	def edit
		@order= Order.find params[:id]
	end

	def update
		@order = Order.find params[:id]
		@order.update_attributes(params[:order].permit!)
		redirect_to routines_client_path(@client)
	end

	private
	def client
		@client = Client.find params[:client_id]
	end
end
