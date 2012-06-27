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
	  		for i in 5..11
	  			if PropertyCategory.exists?(:category_name => row[i].strip.downcase)
	  				pc = PropertyCategory.where(:category_name => row[i].strip.downcase).first
	  				prop_cat << pc.id
	  			else
	  				pc = PropertyCategory.new(:category_name => row[i].strip.downcase)
	  				pc.save!
	  				prop_cat << pc.id
	  			end
	  		end
	  	else
	  		unless row[0].blank? || Product.exists?(:sku => row[0].strip)
	  			p = Product.new(:sku => row[0].strip, :name => row[2].strip.downcase, :price => row[3].strip, :long_description => row[14].strip)
	  			#ANYAG
	  			unless row[5].blank?
		  			anyag = row[5].split(',')
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
	  			for i in 6..11
	  				puts "Current column: " + i.to_s
	  				unless row[i].blank?
			  			if Property.where(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-5)]).any?
		  					prop = Property.where(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-5)]).first
		  					p.properties << prop
		  				else
		  					unless row[i].blank?
			  					prop = Property.new(:property_name => row[i].strip.downcase, :property_category_id => prop_cat[(i-5)])
			  					prop.save!
			  					p.properties << prop
			  				end
		  				end
		  			end
	  			end
	  			#TÖBBI VÉGE
	  			#DESIGNER
	  			unless row[12].blank?
	  				if Designer.where(:name => row[12]).any?
	  					des = Designer.where(:name => row[12]).first
	  				else
	  					des = Designer.new(:name => row[12], :description => '-')
	  					des.save!
	  				end
	  				p.designer_id = des.id
	  			end
	  				#IDEIGLENESEN MINDEN AZ ELSO KATEGORIA
	  				p.category_id = 2
	  			#DESIGNER VÉGE
	  			if p.save
			  		product_counter = product_counter + 1
			  		puts "Succesfully saved: " + counter.to_s + ", sku: " + row[0].to_s
			  	else
			  		puts "Error with product: " + counter.to_s
			  	end
	  		end
	  	end
			counter = counter + 1
		end
    
		puts "Files found: " << counter.to_s
		puts "Files attached to product: " << product_counter.to_s
		puts "Files without product: " << (counter - product_counter).to_s
		puts "All attached files removed permanently!"
		puts (Time.now - time).to_s
  end

  task :categories => :environment do

  	counter = 0

  	CSV.foreach("public/uttermost.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
	  	if counter > 0
	  		if Product.exists?(:sku => row[0])
	  			p = Product.where(:sku => row[0]).first

	  			cat = row[13].strip

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

  	CSV.foreach("public/uttermost_related_products.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
	  	if counter > 0
	  		if Product.exists?(:sku => row[1]) && !row[42].blank?
	  			p = Product.where(:sku => row[1]).first
	  			related = row[42].strip
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
	  	end
	  	counter = counter + 1
  	end
  end

end