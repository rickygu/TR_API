class Campaign < ApplicationRecord
  has_many :campaign_quotas, autosave: true
end
