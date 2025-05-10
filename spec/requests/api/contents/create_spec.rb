# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /api/contents", type: :request do
  before { sign_in user }

  context "when valid params" do
    let(:user) { FactoryBot.create(:user) }

    it "create property and redirect" do
      post api_contents_path, params: {
        content: {
          name: "name",
          file_type: "application/pdf"
        }
      }, headers: { ACCEPT: "text/vnd.turbo-stream.html" }

      expect(response).to be_successful
    end
  end
end
