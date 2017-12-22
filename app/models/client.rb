class Client < ApplicationRecord
  belongs_to :user

  validates_presence_of :contact_person_name, :company_name
end
