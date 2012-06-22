class AdminCustomController < ApplicationController

	def parse_save_from_excel
    file = params[:file_name]
    book = Spreadsheet.open "public/" << file
    sheet1 = book.worksheet 0
    
		columns = []

		head = sheet1.row(0)
		head.each_with_index do |column, i|
			columns[i] = column
		end

		sheet1.each 1 do |row|
			#row = sheet1.row(1)

			category = Category.find_or_create_by_name(:name => row[columns.index("Category")])
			designer = Designer.find_or_create_by_name(:name => row[columns.index("Designer")], :description => 'lorem ipsum')

			params = { :product => { :name => row[columns.index("Product Name")].to_s.capitalize, :long_description => row[columns.index("Marketing Description")], :price => row[columns.index("MAP")], :sku => row[columns.index("Item Number")], :category_id => category.id, :designer_id => designer.id } }
			product = Product.create(params[:product])

			for i in 12..19 do
				property_category = PropertyCategory.find_or_create_by_category_name(:category_name => columns[i])
				if !property_category.categories.exists?(category.id)
					property_category.categories << category
				end
				if !row[i].blank?
					p = Property.find_or_create_by_property_name(:property_name => row[i], :property_category_id => property_category.id)
					product.properties << p
					category.properties << p if !category.properties.exists?(p.id)
				end
			end

			for i in 24..37 do
				property_category = PropertyCategory.find_or_create_by_category_name(:category_name => columns[i])
				if !property_category.categories.exists?(category.id)
					property_category.categories << category
				end
				if !row[i].blank?
					p = Property.find_or_create_by_property_name(:property_name => row[i], :property_category_id => property_category.id)
					product.properties << p
					category.properties << p if !category.properties.exists?(p.id)
				end
			end

    end

		sheet1.each 1 do |row|
			related_product_ids = row[41].to_s.split("|")
			related_product_ids.each do |rel_prod|
				params = { :related_product => {:product_id => row[0], :related_product_id => rel_prod }}
				RelatedProduct.create(params[:related_product])
			end
		end


		redirect_to admin_path
  end

end
