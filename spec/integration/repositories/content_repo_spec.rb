require "rails_helper"

RSpec.describe Repositories::ContentRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }
    let!(:user) { FactoryBot.create(:user) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          name: "test"
        }
      end

      it "create product" do
        expect { create }.to change { Content.count }.by(1)
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
end
