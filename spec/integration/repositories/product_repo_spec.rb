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

  describe "#update_published" do
    subject(:update_published) { described_class.new.update_published(id: product_id, published:) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }
    let(:product_id) { product.id }

    context "set published to true" do
      let(:published) { true }

      it "product published is true" do
        update_published

        expect(product.reload.published).to eq(true)
      end
    end

    context "set published to false" do
      let(:published) { false }

      it "product published is false" do
        update_published

        expect(product.reload.published).to eq(false)
      end
    end
  end

  describe "#update" do
    subject(:update) { described_class.new.update(id: product_id, attrs:) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }
    let(:product_id) { product.id }

    context "update product with attrs" do
      let(:attrs) do
        {
          name: "test"
        }
      end

      it "product updated successfully" do
        update

        expect(product.reload.name).to eq("test")
      end
    end
  end
end
