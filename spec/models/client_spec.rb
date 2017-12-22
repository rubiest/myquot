require 'rails_helper'

RSpec.describe Client, type: :model do
  it "has a valid client factory" do
    expect(FactoryBot.build(:client)).to be_valid
  end

  describe 'validation' do
    it { expect(FactoryBot.build(:client, user: FactoryBot.create(:user))).to be_valid }
    it { expect(FactoryBot.build(:client, user: nil)).not_to be_valid }
    it "should be valid without a contact person name on create" do
      expect(FactoryBot.build(:client, contact_person_name: nil)).not_to be_valid
    end
    it "should be valid with a contact person name on create" do
      expect(FactoryBot.build(:client, contact_person_name: Faker::Name.first_name)).to be_valid
    end
    it "should be valid without a company name on create" do
      expect(FactoryBot.build(:client, company_name: nil)).not_to be_valid
    end
    it "should be valid with a company name on create" do
      expect(FactoryBot.build(:client, company_name: Faker::Name.first_name)).to be_valid
    end
  end
end
