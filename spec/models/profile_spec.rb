require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "has a valid profile factory" do
    expect(FactoryBot.build(:profile)).to be_valid
  end

  describe 'validation' do
    it { expect(FactoryBot.build(:profile, user: FactoryBot.create(:user))).to be_valid }
    it { expect(FactoryBot.build(:profile, user: nil)).not_to be_valid }
    it "should be valid without a first name on create" do
      expect(FactoryBot.build(:profile, first_name: nil)).to be_valid
    end
    it "should be valid with a first_name on create" do
      expect(FactoryBot.build(:profile, first_name: Faker::Name.first_name)).to be_valid
    end
  end
end
