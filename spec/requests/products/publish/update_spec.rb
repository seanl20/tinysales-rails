# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PUT /products", type: :request do
  context "when user is signed in" do
    before { sign_in user }

    context "when valid params" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:product) { FactoryBot.create(:product, user:) }

      it "create property and redirect" do
        put product_publish_path(product), headers: { ACCEPT: "text/vnd.turbo-stream.html" }

        expect(response.status).to eq(200)
      end
    end
  end

  context "when user is not signed in" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }

    it "redirect to sign in path" do
      put product_publish_path(product)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
