require 'rails_helper'

RSpec.describe TapResearchApiServices, type: :service do
  describe 'campaigns' do
    it 'will get all campaigns and store in DB, then get all quota and qualifications' do
      expect( Campaign.count ).to eq 0
      service = TapResearchApiServices.new
      service.get_all_campaigns
      expect( Campaign.count ).to eq 5
      pp "Fetched all campaigns"
      service.get_all_quotas_and_qualifications
      expect( CampaignQuota.count).to eq 10
      expect( CampaignQualification.count).to eq 17
      expect( CampaignQuota.first.campaign).to eq Campaign.first
      expect( CampaignQualification.first.campaign_quota).to eq CampaignQuota.first
      pp "Fetched all quotas and qualifications"
    end
  end
end
