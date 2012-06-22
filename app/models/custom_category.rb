class CustomCategory < ActiveRecord::Base

  default_scope :order => 'custom_category_group_id DESC'

	extend FriendlyId
	friendly_id :name, :use => :slugged

	translates :name

	has_many :custom_category_translations, :dependent => :destroy
	accepts_nested_attributes_for :custom_category_translations

	has_many :properties, :through => :properties_to_custom_categories
	has_many :properties_to_custom_categories

	belongs_to :category
	belongs_to :discount
	belongs_to :custom_category_group

	validates :name,:category_id , :presence => true

	def products(sort='price', params=nil)
		properties_of_custom_category = self.properties

		#query
		unless params.nil?

			q = []
			# params.delete("commit")

			params.each do |key, val|
				unless ((key.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil) || (val.blank?))
					if params[key].kind_of?(Array)
						#Vagy benne van az adott halmazban vagy nincsen benne egyik értékben sem a kategóriáé közül
						q << ("(properties.id IN (" + params[key].join(",") + ") OR (properties.id NOT IN (SELECT id FROM properties WHERE properties.property_category_id=#{key})))")
					else
						v = params[key].split(";")
						# prop_cat = Property.where({:property_category_id => ??, }).property_category_id
						prop_cat = key.to_i
						prop_ids = Property.find(:all, :select => "properties.id", :conditions => ["properties.property_category_id = ? AND properties.property_name BETWEEN #{v[0]} AND #{v[1]}", prop_cat], :group => "properties.id")
						a = []
						prop_ids.each do |prop|
							a << prop.id
						end
						unless a.empty?
							q << ("(properties.id IN (" + a.join(",") + ") OR (properties.id NOT IN (SELECT id FROM properties WHERE properties.property_category_id = #{prop_cat})))")
						end
					end
				end
			end
			
			a = ""
			
			unless params[:designer].blank?
				if params[:designer].include?("NULL")
					params[:designer].delete("NULL")
					a = " OR (products.designer_id IS NULL)"
				end
				q << ("((products.designer_id IN (" + params[:designer].join(",") + "))#{a})")
			end

			q = q.join(" AND ")
			#query

			unless q.blank?
				q = " AND " + q
			end
		end

		p = Product.find(:all, :joins => :properties, :select => "products.*, count(properties.id)", :conditions => ["properties.id IN (?) AND products.category_id = ?#{q}", properties_of_custom_category, self.category_id], :group => "products.id having count(properties.id) = #{properties_of_custom_category.count}", :order => ["products." + sort])
		logger.info "Custom Category products"
		logger.debug "p value: #{p}"
		return p
	end

end
