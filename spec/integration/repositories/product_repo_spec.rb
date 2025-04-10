require "rails_helper"

RSpec.describe Repositories::ProductRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }
    let!(:user) { FactoryBot.create(:user) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          name: "test",
          user:
        }
      end

      it "create product" do
        expect { create }.to change { Product.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {}
      end

      it "does not create property" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#get" do
    subject(:get) { described_class.new.get(id: product_id) }
    let!(:user) { FactoryBot.create(:user) }

    context "product exists" do
      let!(:product) { FactoryBot.create(:product, user:) }
      let(:product_id) { product.id }

      it "is successful" do
        expect(get).to eq(product)
      end
    end

    context "product does not exists" do
      let(:product_id) { "test" }

      it "is not found" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
