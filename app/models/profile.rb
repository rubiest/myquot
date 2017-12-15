class Profile < ApplicationRecord
  belongs_to :user

  validates_presence_of :first_name, on: :update, if: :first_name_changed?
end
