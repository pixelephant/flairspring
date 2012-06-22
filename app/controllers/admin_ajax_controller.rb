class AdminAjaxController < ApplicationController
	def getCategoryProperties
		respond_to do |format|

			cat = params[:category_id].to_i
			property_ids = []
			property_names = []

			if Category.exists?(cat)
				Category.find(cat).property_categories.each do |category|
					category.properties.each do |property|
						property_ids << property.id
						property_names << property.property_category.category_name + ": " + property.property_name
					end
				end
			end

			Property.where("property_category_id IS NULL").each do |property|
				property_ids << property.id

				property_names << property.property_name
			end

			format.json {
				render :json => {:error => "none", :prop_ids => property_ids.as_json, :prop_names => property_names.as_json}
			}
		end
	end
end
