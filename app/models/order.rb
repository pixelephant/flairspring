#encoding: utf-8
class Order < ActiveRecord::Base
	belongs_to :user
	has_many :order_items, :dependent => :destroy
	belongs_to :shipping_address, :class_name => "Address", :foreign_key => "shipping_address_id"
	belongs_to :invoice_address, :class_name => "Address", :foreign_key => "invoice_address_id"
	has_one :coupon

	accepts_nested_attributes_for :order_items

	after_update :send_email_on_status_change

	default_scope :order => 'created_at DESC'

  def send_email_on_status_change
    UserMailer.order_status(self) if (self.status_changed?)
  end

	def order_sum
		sum = 0
		self.order_items.each do |item|
			sum = sum + (item.quantity * item.price)
		end
		return sum
	end

	def status_enum
    [ [ 'Feldolgozás alatt', 'Feldolgozás alatt' ], [ 'Feldolgozva', 'Feldolgozva' ], [ 'Kiszállítás alatt', 'Kiszállítás alatt' ], [ 'Átvehető', 'Átvehető' ], [ 'Teljesítve', 'Teljesítve' ] ]
  end

end