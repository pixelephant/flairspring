class AddSlugToSubcontents < ActiveRecord::Migration
	def change
    add_column :subcontents, :slug, :string
		add_index :subcontents, :slug
  end
end
