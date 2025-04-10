require 'rails_helper'

RSpec.describe Product, type: :model do
  before { FactoryBot.create(:product) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to monetize(:price) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
end
