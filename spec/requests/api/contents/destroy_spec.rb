require 'rails_helper'

RSpec.describe "DELETE /api/contents/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }

  let!(:content) { FactoryBot.create(:content) }

  before { sign_in user }

  it "succeed" do
    delete api_content_path(content), headers: { ACCEPT: "application/json" }

    expect(response.status).to eq(200)
  end
end
