class AddBillingToAddresses < ActiveRecord::Migration
  def change
  	add_column :addresses, :billing, :boolean
  end
end
