class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.references :user, foreign_key: true
      t.string :uniq_id
      t.string :contact_person_name
      t.string :contact_person_email
      t.string :contact_person_phone
      t.string :company_name
      t.text :company_address
      t.string :company_postcode
      t.string :company_city
      t.string :company_state
      t.string :company_country
      t.string :company_email
      t.string :company_phone_number

      t.timestamps
    end
    add_index :clients, :uniq_id, unique: true
  end
end
