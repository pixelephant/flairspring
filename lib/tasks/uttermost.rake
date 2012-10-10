#encoding: utf-8
#
# TASKOK:
# rake import:uttermost - a megfelelően formázott csv dokumentumból importálja a termékeket az adatbázisba
# rake import:categories - a megfelelően formázott csv dokumentumban lévő termékeket a megadott kategóriába rakja
# rake import:related - a megfelelően formázott csv dokumentumban lévő termékkapcsolatokat rakja az adatbázisba
# rake import:last_year - a megfelelően formázott csv dokumentumban felsorolt termékeket eltávolítja az adatbázisból
# rake import:custom_category - a csv dokumentumban lévő "custom category"-kat hozza létre és helyezi el bennük a termékeket 

namespace :import do

  desc "import products from uttermost.csv"

  task :uttermost, [:del] => :environment do |task, args|

  	args.with_defaults(:del => false)

  	time = Time.now
		counter = 0
		product_counter = 0
		prop_cat = []
		puts "Searching for uttermost.csv..."
		puts "Going to delete existing proudcts, properties and property categories" if args.del == 'true'

		row_sku = nil
		row_material = nil
		row_name = nil
		row_designer = nil
		row_price = nil
		row_desc = nil
		row_cat = nil

		# uttermost_utolso_20120926.csv
		# public/uttermost_2012_balazs.csv
		# teljes_arlista_kategoriakkal.csv
		# teljes_arlista_related_20121003.csv
		CSV.foreach("public/teljes_arlista_related_20121003.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|

			# row_sku = 0
			# row_material = 0
			# row_name = 0
			# row_designer = 0
			# row_price = 0
			# row_desc = 0
			# row_cat = 0

	  	if counter == 0
	  		puts "Deleting property categories..." if args.del == 'true'
	  		PropertyCategory.find_each(&:delete) if args.del == 'true'
	  		puts "Deleting products..." if args.del == 'true'
	  		Product.find_each(&:delete) if args.del == 'true'
	  		puts "Deleting properties..." if args.del == 'true'
	  		Property.find_each(&:delete) if args.del == 'true'
	  		
	  		row.each_with_index do |r,i|
	  			if(r.to_s.strip.downcase == 'anyag' || r.to_s.strip.downcase == 'anyaga')
	  				row_material = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'tervező' || r.to_s.strip.downcase == 'designer')
	  				row_designer = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'termék neve' || r.to_s.strip.downcase == 'név')
	  				row_name = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'cikkszám' || r.to_s.strip.downcase == 'sku' || r.to_s.strip.downcase == 'termékszám')
	  				row_sku = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'ár' || r.to_s.strip.downcase == 'kisker ár (ft)' || r.to_s.strip.downcase == 'kisker ár')
	  				row_price = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'leírás' || r.to_s.strip.downcase == 'marketing leírás')
	  				row_desc = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'kategóra' || r.to_s.strip.downcase == 'kategória')
	  				row_cat = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  		end

	  		for i in (row_material + 1)..(row_designer - 1)
	  			puts row[i]
	  			if PropertyCategory.exists?(:category_name => row[i].strip.downcase)
	  				puts "PropertyCategoryFound: " + row[i].to_s
	  				pc = PropertyCategory.where(:category_name => row[i].strip.downcase).first
	  				prop_cat << pc.id
	  			else
	  				puts "PropertyCategoryCreated: " + row[i].to_s
	  				pc = PropertyCategory.new(:category_name => row[i].strip.downcase)
	  				pc.save!
	  				prop_cat << pc.id
	  			end
	  		end

	  		puts "row_sku: " + row_sku.to_s
				puts "row_material: " + row_material.to_s
				puts "row_name: " + row_name.to_s
				puts "row_designer: " + row_designer.to_s
				puts "row_price: " + row_price.to_s
				puts "row_desc: " + row_desc.to_s
				puts "row_cat: " + row_cat.to_s

	  	else
	  		unless row[row_sku].blank?
	  			puts "SKU: " + row[row_sku]
	  			if Product.exists?(:sku => row[row_sku].strip)
	  				puts "Product exists"
	  				p = Product.find_by_sku(row[row_sku].strip)
	  				p.name = row[row_name].strip.downcase
	  				p.price = row[row_price].strip
	  				p.long_description = row[row_desc].strip
	  			else
	  				puts "New product"
	  				p = Product.new(:sku => row[row_sku].strip, :name => row[row_name].strip.downcase, :price => row[row_price].strip, :long_description => row[row_desc].strip)
	  			end
	  			#ANYAG
	  			unless row[row_material].blank?
		  			anyag = row[row_material].split(',')
		  			anyag_cat = PropertyCategory.find_by_category_name("anyag")
		  			anyag.each do |a|
		  				unless a.strip.blank?
			  				if Property.where(:property_name => a.strip.downcase, :property_category_id => 1).any?
			  					prop = Property.where(:property_name => a.strip.downcase, :property_category_id => 1).first
			  				else
			  					prop = Property.new(:property_name => a.strip.downcase, :property_category_id => 1)
			  					prop.save!
			  				end
			  				begin p.properties << prop

			  				rescue Exception => e
					  			puts "Product property exists: #{e.class}"
								end
			  			end
		  			end
		  		end
	  			#TÖBBI
	  			for i in (row_material + 1)..(row_designer - 1)
	  				puts "Current column: " + i.to_s
	  				puts "Property: " + row[i].to_s
	  				unless row[i].blank?
			  			if Property.where(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-(row_material+1))]).any?
		  					prop = Property.where(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-(row_material+1))]).first
		  					begin p.properties << prop

		  					rescue Exception => e
					  			puts "Product property exists: #{e.class}"
								end
		  				else
		  					unless row[i].blank?
			  					prop = Property.new(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-(row_material+1))])
			  					prop.save!
			  					begin p.properties << prop

			  					rescue Exception => e
						  			puts "Product property exists: #{e.class}"
									end
			  				end
		  				end
		  			end
	  			end
	  			#TÖBBI VÉGE
	  			#DESIGNER
	  			unless row[row_designer].blank?
	  				if Designer.where(:name => row[row_designer]).any?
	  					des = Designer.where(:name => row[row_designer]).first
	  				else
	  					des = Designer.new(:name => row[row_designer], :description => '-')
	  					des.save!
	  				end
	  				p.designer_id = des.id
	  			end
	  				#IDEIGLENESEN MINDEN AZ ELSO KATEGORIA
	  				# p.category_id = Category.where(:name => row[row_cat]).first.id
	  				p.category_id = Category.first.id
	  				p.brand_id = 1
	  			#DESIGNER VÉGE
	  			begin p.save
						puts "Succesfully saved: " + counter.to_s + ", sku: " + row[row_sku].to_s
						product_counter = product_counter + 1
					rescue Exception => e
		  			puts "Error with product: #{e.class}"
					end
			  	Rails.logger.debug p.errors.full_messages
	  		end
	  	end
			puts counter = counter + 1
		end
    
		puts (Time.now - time).to_s
  end

  task :categories => :environment do

  	counter = 0
  	row_id = 0
  	row_sku = nil

  	# uttermost_utolso_20120926.csv
		# public/uttermost_2012_balazs.csv
		# teljes_arlista_related_20121003.csv
  	CSV.foreach("public/teljes_arlista_related_20121003.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|

  		puts "Counter: " + counter.to_s + ", Row: " + row_id.to_s

	  	if counter > 0 && row_id > 0

	  		puts "Id: " + row_id.to_s
  			puts "Sku: " + row_sku.to_s

	  		if Product.exists?(:sku => row[row_sku])
	  			p = Product.where(:sku => row[row_sku]).first

	  			cat = row[row_id].strip
	  		
	  			puts "Category: " + cat.to_s
	  			puts "Product: " + p.name.to_s

	  			if cat == "TÜKRÖK"
	  				cat_id = Category.where(:name => 'Tükrök').first.id
	  			end

	  			if cat == 'MŰVÉSZETI ALKOTÁSOK' || cat == 'ÓRÁK' || cat == 'KIEGÉSZÍTŐK' || cat == 'NÖVÉNYEK'
	  				cat_id = Category.where(:name => 'Kiegészítők').first.id
	  			end

	  			if cat == 'FÉM FALI DÍSZ'
	  				cat_id = Category.where(:name => 'Faldekor').first.id
	  			end

	  			if cat == 'FALILÁMPÁK ÉS FÜGGESZTÉKEK' || cat == 'LÁMPÁK'
	  				cat_id = Category.where(:name => 'Lámpák').first.id
	  			end

	  			if cat == 'KIEGÉSZÍTŐ BÚTOR'
	  				cat_id = Category.where(:name => 'Bútorok').first.id
	  			end

	  			p.category_id = cat_id
	  			if p.save
	  				puts "Category changed"
	  			else
	  				puts "Category change error"
	  			end
	  		end
	  	else
	  		row.each_with_index do |r,i|
	  			if(r.to_s.strip.downcase == 'kategória' || r.to_s.strip.downcase == 'category' || r.to_s.strip.downcase == 'kategóra')
	  				row_id = i
	  				puts "Id Oszlop sorszáma: " + i.to_s
	  			end
	  			if(r.to_s.strip.downcase == 'cikkszám' || r.to_s.strip.downcase == 'sku' || r.to_s.strip.downcase == 'termékszám')
	  				row_sku = i
	  				puts "Sku Oszlop sorszáma: " + i.to_s
	  			end
	  		end
	  	end
	  	counter = counter + 1
  	end

  	puts counter
  end

  task :related => :environment do

  	counter = 0
  	row_id = 0

  	CSV.foreach("public/teljes_arlista_related_20121003.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
  		puts counter
	  	if counter > 0 && row_id > 0
	  		if Product.exists?(:sku => row[0]) && !row[row_id].blank?
	  			p = Product.where(:sku => row[0]).first
	  			related = row[row_id].strip
	  			related_products = related.split("|")
	  			
	  			related_products.each do |rel|
	  				if Product.exists?(:sku => rel)
	  					begin p.product_relates << Product.where(:sku => rel).first

	  					rescue Exception => e
	  						puts "Related products change error: #{e.class}"
	  					end
	  				end
	  			end

	  			begin p.save
						puts "Related products changed"
					rescue Exception => e
		  			puts "Related products change error: #{e.class}"
					end
	  		end
	  	else
	  		row.each_with_index do |r,i|
	  			if(r.to_s.strip.downcase == 'related products' || r.to_s.strip.downcase == 'kapcsolódó termékek' || r.to_s.strip.downcase == 'related items')
	  				row_id = i
	  				puts "Oszlop sorszáma: " + i.to_s
	  			end
	  		end
	  	end
	  	counter = counter + 1
  	end
  end

  task :last_year => :environment do

  	counter = 0

  	puts "Reading file: last_year.CSV"
  	CSV.foreach("public/last_year.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
  		if Product.exists?(:sku => row[0]) && row[7] == 'kifutott'
  			Product.find_by_sku(row[0]).delete
  			puts "Product: " + row[0] + " deleted!"
  		end
  		puts counter = counter + 1
  	end

  end

  task :delete_products, [:col] => :environment do |task, args|

  	args.with_defaults(:col => 1)

  	time = Time.now
		counter = 0
		del_counter = 0
		puts "Searching for uttermost.csv..."
		puts "Going to delete existing proudcts"
 
		CSV.foreach("public/uttermost.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
			if counter > 0
				if Product.where(:sku => row[args.col]).any?
					del_counter = del_counter + 1 if Product.find_by_sku(row[args.col]).delete
					puts row[args.col]
				end
			end
			puts counter = counter + 1
		end

		puts "Deleted: " + del_counter.to_s
		puts (Time.now - time).to_s

  end

  task :custom_category, [:col1, :col2] => :environment do |task, args|
  	require 'csv'

  	args.with_defaults(:col1 => 16)
  	args.with_defaults(:col2 => 78)

  	time = Time.now
		counter = 0
		del_counter = 0
		puts "Searching for Minta_kategoria_lista_balazs.csv..."
		puts "Going to add products to custom category"
 
 		c_categories = []
 		categ = []
 		c_categories_gr = []

		CSV.foreach("public/teljes_arlista_related_20121003.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|

			if counter == 0
				for i in (args.col1)..(args.col2)
					categ << row[i]
					puts row[i].to_s + " - " + i.to_s
				end

				# for i in 16..78
				# 	puts row[i].to_s + " - " + i.to_s
				# end
			end

			if counter == 1
				for i in 16..78
					index = i - 16
					unless PropertyCategory.exists?(:category_name => row[i])
						puts "Property category: " + row[i].to_s
						p = PropertyCategory.create(:category_name => row[i])
					else
						p = PropertyCategory.find_by_category_name(row[i])
					end

					puts i.to_s + " - Category: " + categ[index].to_s

					unless Category.find_by_name(categ[index]).property_categories.include?(p)
						Category.find_by_name(categ[index]).property_categories << p
					end

					if CustomCategoryGroup.find_by_name(row[i]).blank?
						custom = CustomCategoryGroup.create(:name => row[i])
					end

					c_categories_gr << row[i]
				end
			end

			if counter == 2
				for i in (args.col1)..(args.col2)
					a = (i-args.col1)
					puts "Custom Category: " + row[i]

					if c_categories_gr[a] == "Anyagok"
						p = row[i].split(" ")
						p_name = p[0]
					else
						p_name = row[i]
					end

					p_cat = PropertyCategory.find_by_category_name(c_categories_gr[a]).id

					unless Property.where(:property_name => p_name, :property_category_id => p_cat).any?
						puts "PropCat name: " + c_categories_gr[a]
						pcid = PropertyCategory.find_by_category_name(c_categories_gr[a]).id
						Property.create(:property_name => p_name, :property_category_id => pcid)
					end

					property = Property.where(:property_name => p_name, :property_category_id => p_cat).first

					unless CustomCategory.exists?(:name => row[i])
						puts "Custom Category Group: " + c_categories_gr[a]
						custom_group = CustomCategoryGroup.find_by_name(c_categories_gr[a]).id
						category_id = Category.find_by_name(categ[a]).id
						custom = CustomCategory.create(:name => row[i], :custom_category_group_id => custom_group, :category_id => category_id)
					end

					unless CustomCategory.find_by_name(row[i]).properties.include?(property)
						puts "Adding property (" + property.property_name + ") to cutom category"
						CustomCategory.find_by_name(row[i]).properties << property
					end

					c_categories << row[i]
				end
			end

			if counter > 2
				if Product.where(:sku => row[0]).any?
					prod = Product.find_by_sku(row[0])
					puts "Product found: " + row[0]
					for i in 16..78
						index = (i.to_i - args.col1.to_i)
					  if row[i] == 'x' || row[i] == 'X'
					   	c_name = (c_categories[index])
					   	puts "Value found: " + c_name

					   	if c_categories_gr[index] == 'Anyagok'
					   		puts "Anyagok: " + c_categories[index]
								p = c_categories[index].split(" ")
								p_name = p[0]
							else
								p_name = c_categories[index]
							end

					   	property = Property.find_by_property_name(p_name)

					   	unless prod.properties.include?(property)
					   		prod.properties << property
					   	end

					   	if prod.save!
			   				puts "Property added: " + p_name + " to product: " + prod.name
			   			end

					  end
					end
				end
			end
			counter = counter + 1
		end

		puts (Time.now - time).to_s
  end

end