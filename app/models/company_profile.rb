class CompanyProfile < ApplicationRecord
  belongs_to :user
  has_many :quotations

  validates_presence_of :company_name, :reg_num
end
