require "rails_helper"

RSpec.describe Products::Commands::Create, "#call", :db do
  let(:query) { described_class.new }
  let!(:user) { FactoryBot.create(:user) }

  subject(:call) do
    query.call(params:, user:)
  end

  context "when price is a string" do
    let(:params) do
      {
        name: "test",
        price: "test"
      }
    end

    it "returns payment" do
      expect { call }.to change { Product.count }.by(1)
    end
  end

  context "when price is am integer" do
    let(:params) do
      {
        name: "test",
        price: 123
      }
    end

    it "returns empty" do
      expect { call }.to change { Product.count }.by(1)
    end
  end
end
