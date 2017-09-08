class CampaignQuota < ApplicationRecord
  belongs_to :campaign
  has_many :campaign_qualifications, autosave: true
end
