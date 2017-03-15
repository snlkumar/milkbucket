class HistoriesController < ApplicationController
	def new
		@history = History.new
		@milk = Product.milk
		@dahi = Product.dahi
		
	end

	def create
		status = false		
	    @history = History.new history_params.permit!
	    status = true if @history.save	    
		render json: {status: status, errors: @history.errors.full_messages[0], message: " Order Created Successfully."}		
	end

	def cash
	  @cash_history = History.cash_deposited		
	end

	def add_cash
		history = History.new params[:cash].permit!
		if history.save
			redirect_to cash_histories_path
		end
	end
	private
	def history_params
		change_param = params[:order]
		change_param[:particular] = change_param[:particular].to_json
		change_param
	end
end
