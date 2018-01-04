class AddSenderToQuotation < ActiveRecord::Migration[5.1]
  def change
    add_reference :quotations, :sender, foreign_key: { to_table: :company_profiles }
  end
end
