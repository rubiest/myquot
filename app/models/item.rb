class Item < ApplicationRecord
  belongs_to :itemable, polymorphic: true, optional: true

  validates_presence_of :description
end
