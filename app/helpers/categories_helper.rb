module CategoriesHelper
	def topCategories
		Category.where(["category_id IS NULL"])
	end
end
