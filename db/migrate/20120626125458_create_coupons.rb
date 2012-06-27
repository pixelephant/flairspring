class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|

    	t.string :code
    	t.boolean :used
    	t.integer :offer_value
    	t.integer :offer_type
    	t.date :valid

      t.timestamps
    end
  end
end
