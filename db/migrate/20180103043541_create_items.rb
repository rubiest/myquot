class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :description
      t.references :itemable, polymorphic: true, index: true
      t.integer :quantity, default: 0
      t.decimal :price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
