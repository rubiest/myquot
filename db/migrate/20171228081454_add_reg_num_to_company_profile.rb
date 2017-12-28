class AddRegNumToCompanyProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :company_profiles, :reg_num, :string
    add_index :company_profiles, :reg_num, unique: true
  end
end
