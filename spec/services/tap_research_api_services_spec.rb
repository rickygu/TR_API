require 'rails_helper'

RSpec.describe TapResearchApiServices, type: :service do
  describe 'campaigns' do

    it 'will get all campaigns and store in DB, then get all quota and qualifications' do
      time = Benchmark.measure do
        expect( Campaign.count ).to eq 0
        expect( CampaignQuota.count).to eq 0
        expect( CampaignQualification.count).to eq 0
        service = TapResearchApiServices.new
        service.get_all_campaigns_quotes_and_qualifications
        expect( Campaign.count ).to eq 5
        expect( CampaignQuota.count).to eq 10
        expect( CampaignQualification.count).to eq 17
        expect( CampaignQuota.first.campaign).to eq Campaign.first
        expect( CampaignQualification.first.campaign_quota).to eq CampaignQuota.first
      end
    end

  end
end
