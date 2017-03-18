class ItemsController < ApplicationController
	before_action :item
	def index				
		@items= Item.where(client_id: params[:client_id])
	end

	def edit
		render 'index'
	end

	def create
		@item = Item.new params[:item].permit!
		if @item.save
			flash[:notice] = "Item Created Successfully"
		else
			flash[:error] = @item.errors.full_messages
		end
		redirect_to client_items_path(@client)
	end

	def update		
		if @item.update_attributes(params[:item].permit!)			
			flash[:notice] = "Item Updated Successfully"
		else
			flash[:error] = @item.errors.full_messages
		end 
		redirect_to client_items_path(@client)
	end

	

	def destroy

	end

	private
	def item
		@client = Client.find params[:client_id]
		@item = params[:id] ? Item.find(params[:id]) : Item.new(client_id: params[:client_id])
	end
end
