# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PUT /products/:id", type: :request do
  before { sign_in user }

  context "when valid params" do
    let(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }

    it "create property and redirect" do
      put product_path(product), params: {
        product: {
          name: "name",
          slug: "name",
          price: 123
        }
      }

      expect(response).to be_redirect
    end
  end
end
