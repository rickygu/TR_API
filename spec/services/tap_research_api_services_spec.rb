require 'rails_helper'

RSpec.describe TapResearchApiServices, type: :service do
  describe 'campaigns' do
    it 'will get all campaigns and store in DB' do
      expect( Campaign.count ).to eq 0
      service = TapResearchApiServices.new
      service.get_all_campaigns
      expect( Campaign.count ).to eq 5
    end
  end
end
