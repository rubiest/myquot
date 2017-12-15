require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid user factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "has a valid admin factory" do
    expect(FactoryBot.build(:admin)).to be_valid
  end

  describe 'validation' do
    it { expect(FactoryBot.build(:user, username: nil)).not_to be_valid }
    it { expect(FactoryBot.build(:user, email: nil)).not_to be_valid }
    it { expect(FactoryBot.build(:user, password: nil)).not_to be_valid }

    it { expect(FactoryBot.build(:user, username: Faker::Internet.user_name)).to be_valid }
    it { expect(FactoryBot.build(:user, email: Faker::Internet.email)).to be_valid }
    it { expect(FactoryBot.build(:user, password: 'secret')).to be_valid }
    it { expect(FactoryBot.build(:user, password_confirmation: 'secret')).to be_valid }
    it { expect(FactoryBot.build(:user, confirmed_at: nil)).to be_valid }

    it 'password confirmation' do
      expect do
        create(:user,
               password: 'secret',
               password_confirmation: 'another_secret')
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect(create(:user, password: 'secret',
                           password_confirmation: 'secret')).to be_valid
    end

    # test with profile
    describe "profile" do
      it "should have a valid profile factory" do
        expect(FactoryBot.create(:profile)).to be_valid
      end
    end
  end
end
