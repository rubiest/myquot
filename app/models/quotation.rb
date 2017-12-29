class Quotation < ApplicationRecord
  enum status: [:saved, :sent, :accepted, :rejected]
  belongs_to :user
  belongs_to :client

  after_create :create_ref_number

  def create_ref_number
    random = [('A'..'Z'), ('1'..'9')].map { |i| i.to_a }.flatten
    ref_number = (0...7).map { random[rand(random.length)] }.join
    self.update_attribute(:ref_number, "MQQ-" + ref_number)
  end
end
