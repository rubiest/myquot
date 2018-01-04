require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid comment factory" do
    expect(FactoryBot.build(:item)).to be_valid
  end

  describe 'validation' do
    it { expect(FactoryBot.build(:item, description: "Hello world")).to be_valid }
    it { expect(FactoryBot.build(:item, description: nil)).not_to be_valid }
  end
end
