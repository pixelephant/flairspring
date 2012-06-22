class CreateAdvantages < ActiveRecord::Migration
  def change
    create_table :advantages do |t|
      t.string :advantage, :null => false, :unique => true

      t.timestamps
    end
  end
end
