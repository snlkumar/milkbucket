module CategoriesHelper
	def category_id
		debugger
		Category.where(name: params[:category]).first.id
	end
end
