require 'rails_helper'

RSpec.describe Quotation, type: :model do
  it "has a valid quotation factory" do
    expect(FactoryBot.build(:quotation)).to be_valid
  end

  describe 'validation' do
    it { expect(FactoryBot.build(:quotation, user: FactoryBot.create(:user))).to be_valid }
    it { expect(FactoryBot.build(:quotation, client: FactoryBot.create(:client))).to be_valid }
    it { expect(FactoryBot.build(:quotation, user: nil)).not_to be_valid }
    it { expect(FactoryBot.build(:quotation, client: nil)).not_to be_valid }
    it "should have ref_number after quotation is created" do
      expect(FactoryBot.build(:quotation, ref_number: Faker::Code.asin)).to be_valid
    end
  end
end
