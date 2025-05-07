# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /products/:product_id/contents", type: :request do
  context "when user is signed in" do
    before { sign_in user }

    context "when product exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:product) { FactoryBot.create(:product, user:) }

      it "create property and redirect" do
        get product_contents_path(product)

        expect(response).to be_successful
      end
    end

    context "when product does not exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:product_id) { 1 }

      it "create property and redirect" do
        get product_contents_path(product_id)

        expect(response.status).to eq 404
      end
    end
  end

  context "when user is not signed in" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }

    it "redirect to sign in path" do
      get product_contents_path(product)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
