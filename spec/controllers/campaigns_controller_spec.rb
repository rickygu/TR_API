require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  describe "GET #ordered_campaigns" do
    it "returns http success" do
      get :ordered_campaigns
      expect(response).to have_http_status(:success)
    end
  end

end
