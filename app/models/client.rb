class Client < ApplicationRecord
  belongs_to :user
  has_many :quotations

  validates_presence_of :contact_person_name, :company_name

  after_create :create_uniq_id

  def create_uniq_id
    random = [('A'..'Z'), ('1'..'9')].map { |i| i.to_a }.flatten
    uniq_id = (0...5).map { random[rand(random.length)] }.join
    self.update_attribute(:uniq_id, "MQ-" + uniq_id)
  end

  def client_details
    "#{contact_person_name} (#{uniq_id}) - #{company_name}"
  end
end
