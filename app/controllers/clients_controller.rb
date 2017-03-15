class ClientsController < ApplicationController
	before_action :my_shared_method
	def index
		@clients = Client.all
	end

	# def new
	# 	p @client
	# 	@clients = Client.all
	# end

	def create
		@client = Client.new params[:client].permit!
		if @client.save
			redirect_to clients_path
		else
			render 'new'
		end

	end

	def edit
		@clients = Client.all
	end

	def update
		if @client.update_attributes(params[:client].permit!)
			redirect_to clients_path
		else
			render 'edit'
		end
	end

	def destroy
		@client.destroy
		redirect_to clients_path
	end

	def new_order
		items = @client.items
		@order = Order.new(client_id: @client.id)
		items.each do |item|
		  @order.order_items.build(item_id: item.id, )
		end
	end



	def routines
		@orders = @client.orders
	end

	private
	def my_shared_method		
		@client = params[:id] ? Client.find(params[:id]) : Client.new
	end
end
