require 'rails_helper'

RSpec.describe "GET /products/:id", type: :request do
  context "when user is not signed in" do
    let(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }

    it "return success" do
      get product_path(product)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    let(:user) { FactoryBot.create(:user) }
    let!(:product) { FactoryBot.create(:product, user:) }

    before { sign_in user }

    it "redirect to dashboard path" do
      get product_path(product)

      expect(response).to be_successful
    end
  end
end
