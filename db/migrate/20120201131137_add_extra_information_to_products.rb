class AddExtraInformationToProducts < ActiveRecord::Migration
	def change
    add_column :products, :advice, :text
    add_column :products, :video, :string
  end
end
