module CategoriesHelper
	def category_id		
		Category.where(name: params[:category]).first.id
	end
end
