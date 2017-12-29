class CreateQuotations < ActiveRecord::Migration[5.1]
  def change
    create_table :quotations do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.string :ref_number
      t.datetime :valid_until
      t.integer :status, default: 0
      t.decimal :sub_total, precision: 8, scale: 2 #ex: 1298.00
      t.decimal :tax_rate, precision: 4, scale: 3 #ex: 10.00 %
      t.decimal :tax, precision: 8, scale: 2 #ex: 129.80
      t.decimal :total, precision: 8, scale: 2 #ex: 1427.80
      t.text :note

      t.timestamps
    end
    add_index :quotations, :ref_number, unique: true
  end
end
