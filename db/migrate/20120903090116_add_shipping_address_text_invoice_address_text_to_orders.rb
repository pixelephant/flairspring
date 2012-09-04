class AddShippingAddressTextInvoiceAddressTextToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :invoice_address_text, :text
  	add_column :orders, :shipping_address_text, :text
  end
end
