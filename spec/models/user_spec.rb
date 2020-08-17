require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:addresses) }

  context 'validation for uniqueness of email`' do
    subject { build(:user) }

    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
