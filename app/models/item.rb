class Item < ApplicationRecord
  belongs_to :itemable, polymorphic: true

  validates_presence_of :description
end
