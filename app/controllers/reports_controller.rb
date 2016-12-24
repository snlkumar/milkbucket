class ReportsController < ApplicationController
	def index
	end

	def show_report
		from = Date.parse(params[:from])
		to = Date.parse(params[:to])
		# result = History.where(created_at: from..to).group_by{|x| x.created_at.strftime('%F')}
		# result = History.where(created_at: from..to)
		result = History.all		
		render json: {data: result }		
	end
	
end
