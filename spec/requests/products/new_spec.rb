require 'rails_helper'

RSpec.describe "GET /products/new", type: :request do
  context "when user is not signed in" do
    it "return success" do
      get new_product_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    let(:user) { FactoryBot.create(:user) }

    before { sign_in user }

    it "redirect to root path" do
      get new_product_path

      expect(response).to be_successful
    end
  end
end
