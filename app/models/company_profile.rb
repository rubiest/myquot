class CompanyProfile < ApplicationRecord
  belongs_to :user

  validates_presence_of :company_name, :reg_num
end
