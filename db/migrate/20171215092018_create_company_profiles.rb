class CreateCompanyProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :company_profiles do |t|
      t.references :user, foreign_key: true
      t.string :company_name
      t.string :contact_number
      t.text :address
      t.string :postcode
      t.string :city
      t.string :state
      t.string :country
      t.string :logo

      t.timestamps
    end
  end
end
