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

  describe "#get" do
    subject(:get) { described_class.new.get(id: content_id) }

    context "content exists" do
      let!(:content) { FactoryBot.create(:content) }
      let(:content_id) { content.id }

      it "is successful" do
        expect(get).to eq(content)
      end
    end

    context "content does not exists" do
      let(:content_id) { "test" }

      it "is not found" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#get_by_ids" do
    subject(:get_by_ids) { described_class.new.get_by_ids(ids:) }

    context "contents exists" do
      let!(:content_1) { FactoryBot.create(:content) }
      let!(:content_2) { FactoryBot.create(:content) }
      let!(:content_3) { FactoryBot.create(:content) }
      let(:ids) { [ content_1.id, content_2.id, content_3.id ] }

      it "is successful" do
        expect(get_by_ids).to match_unordered_elements(content_1, content_2, content_3)
      end
    end

    context "content does not exists" do
      let(:ids) { [] }

      it "is not found" do
        expect(get_by_ids).to be_empty
      end
    end
  end

  describe "#update" do
    subject(:update) { described_class.new.update(id: content_id, attrs:) }
    let!(:content) { FactoryBot.create(:content) }
    let(:content_id) { content.id }

    context "update content with attrs" do
      let(:attrs) do
        {
          name: "test"
        }
      end

      it "content updated successfully" do
        update

        expect(content.reload.name).to eq("test")
      end
    end
  end
end
