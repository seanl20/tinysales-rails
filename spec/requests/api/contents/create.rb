# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /products", type: :request do
  before { sign_in user }

  context "when valid params" do
    let(:user) { FactoryBot.create(:user) }

    it "create property and redirect" do
      post api_contents_path, params: {
        product: {
          name: "name"
        }
      }

      expect(response).to be_successful
    end
  end
end
