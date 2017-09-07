class CampaignsController < ApplicationController
  def ordered_campaigns
    render json: Campaign.all.order(:name)
  end
end
