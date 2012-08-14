#encoding: utf-8
class ProductPdf < Prawn::Document

  require 'fastimage'

	def initialize(product, view)
    super(:page_size => 'A4', :page_layout => :landscape, :margin => [0,0,0,0])

    @product = product
    @view = view

    self.font("/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf")

    #Background
    image "/media/Data/Work/Projects/flairspring/public/hatter.png", :width => 845, :height => 595

    move_up 550

    # text "Név: " + product.name.titleize, :indent_paragraphs => 0

    table properties_table, :width => 350 do
    	columns(0..1).align = :center
    	self.header = false
    	self.column_widths = {0 => 150, 1 => 200}
    end

    move_up 200

    img_size = FastImage.size(product.photos.first.image_file.path)
    w = (img_size[0].to_f * (200/img_size[1].to_f)).to_i

    y_position = cursor
    image "/media/Data/Work/Projects/flairspring/public/fp_frame.png", :height => 210, :width => w+10, :at => [385, y_position+3]
    image product.photos.first.image_file.path, :height => 200, :at => [390, y_position], :border => 2
  end

  def properties_table
  	[["Dátum", DateTime.now.to_s(:db)]] + [["Név", @product.name.titleize]] + [["Tervező", @product.designer.name.titleize]] + [["Ár", @view.number_to_currency(@product.price, :precision => 0, :separator => ".", :unit => "Ft", :delimiter => " ")]] + 

  	@product.properties.order(:property_category_id).map do |prop|
  		[prop.property_category.category_name.titleize, prop.property_name.titleize]
  	end
  end

end