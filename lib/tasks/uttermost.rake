#encoding: utf-8
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
 
		CSV.foreach("public/uttermost.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
	  	if counter == 0
	  		puts "Deleting property categories..." if args.del == 'true'
	  		PropertyCategory.find_each(&:delete) if args.del == 'true'
	  		puts "Deleting products..." if args.del == 'true'
	  		Product.find_each(&:delete) if args.del == 'true'
	  		puts "Deleting properties..." if args.del == 'true'
	  		Property.find_each(&:delete) if args.del == 'true'
	  		for i in 9..20
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
	  	else
	  		unless row[1].blank? || Product.exists?(:sku => row[1].strip)
	  			puts row[1]
	  			p = Product.new(:sku => row[1].strip, :name => row[3].strip.downcase, :price => row[4].strip, :long_description => row[7].strip)
	  			#ANYAG
	  			unless row[9].blank?
		  			anyag = row[9].split(',')
		  			anyag.each do |a|
		  				unless a.strip.blank?
			  				if Property.where(:property_name => a.strip.downcase, :property_category_id => prop_cat[0]).any?
			  					prop = Property.where(:property_name => a.strip.downcase).first
			  				else
			  					prop = Property.new(:property_name => a.strip.downcase, :property_category_id => prop_cat[0])
			  					prop.save!
			  				end
			  				p.properties << prop
			  			end
		  			end
		  		end
	  			#TÖBBI
	  			for i in 10..20
	  				puts "Current column: " + i.to_s
	  				puts "Property: " + row[i].to_s
	  				unless row[i].blank?
			  			if Property.where(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-9)]).any?
		  					prop = Property.where(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-9)]).first
		  					p.properties << prop
		  				else
		  					unless row[i].blank?
			  					prop = Property.new(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-9)])
			  					prop.save!
			  					p.properties << prop
			  				end
		  				end
		  			end
	  			end
	  			#TÖBBI VÉGE
	  			#DESIGNER
	  			unless row[6].blank?
	  				if Designer.where(:name => row[6]).any?
	  					des = Designer.where(:name => row[6]).first
	  				else
	  					des = Designer.new(:name => row[6], :description => '-')
	  					des.save!
	  				end
	  				p.designer_id = des.id
	  			end
	  				#IDEIGLENESEN MINDEN AZ ELSO KATEGORIA
	  				p.category_id = 2
	  			#DESIGNER VÉGE
	  			if p.save
			  		product_counter = product_counter + 1
			  		puts "Succesfully saved: " + counter.to_s + ", sku: " + row[1].to_s
			  	else
			  		puts "Error with product: " + counter.to_s
			  	end
	  		end
	  	end
			puts counter = counter + 1
		end
    
		puts (Time.now - time).to_s
  end

  task :categories => :environment do

  	counter = 0

  	CSV.foreach("public/uttermost.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
	  	if counter > 0
	  		if Product.exists?(:sku => row[1])
	  			p = Product.where(:sku => row[1]).first

	  			cat = row[8].strip

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
	  	end
	  	counter = counter + 1
  	end
  end

  task :related => :environment do

  	counter = 0
  	row_id = 0

  	CSV.foreach("public/uttermost.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
  		puts counter
	  	if counter > 0 && row_id > 0
	  		if Product.exists?(:sku => row[1]) && !row[row_id].blank?
	  			p = Product.where(:sku => row[1]).first
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
	  			if(r.to_s.strip.downcase == 'related products' || r.to_s.strip.downcase == 'kapcsolódó termékek')
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

end