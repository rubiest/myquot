require 'rails_helper'

RSpec.describe CompanyProfile, type: :model do
  it "has a valid company profile factory" do
    expect(FactoryBot.build(:company_profile)).to be_valid
  end

  describe 'validation' do
    it { expect(FactoryBot.build(:company_profile, user: FactoryBot.create(:user))).to be_valid }
    it { expect(FactoryBot.build(:company_profile, user: nil)).not_to be_valid }
    it "should be valid without a company name on create" do
      expect(FactoryBot.build(:company_profile, company_name: nil)).not_to be_valid
    end
    it "should be valid with a company name on create" do
      expect(FactoryBot.build(:company_profile, company_name: Faker::Name.first_name)).to be_valid
    end
  end
end
