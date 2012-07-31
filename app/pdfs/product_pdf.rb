#encoding: utf-8
class ProductPdf < Prawn::Document

	def initialize(product, view)
    super()

    @product = product
    @view = view

    self.font("/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf")

    #Background
    # image product.photos.first.image_file.path, :height => 400, :width => 300

    # move_up 400

    # text "Név: " + product.name.titleize, :indent_paragraphs => 0

    table properties_table, :width => 350 do
    	columns(0..1).align = :center
    	self.header = false
    	self.column_widths = {0 => 150, 1 => 200}
    end

    move_up 200

    y_position = cursor
    image product.photos.first.image_file.path, :height => 200, :at => [390, y_position]
  end

  def properties_table
  	[["Dátum", DateTime.now.to_s(:db)]] + [["Név", @product.name.titleize]] + [["Tervező", @product.designer.name.titleize]] + [["Ár", @view.number_to_currency(@product.price, :precision => 0, :separator => ".", :unit => "Ft", :delimiter => " ")]] + 

  	@product.properties.order(:property_category_id).map do |prop|
  		[prop.property_category.category_name.titleize, prop.property_name.titleize]
  	end
  end

end