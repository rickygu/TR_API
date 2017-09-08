class TapResearchApiServices
  BASE_URI = ENV['TR_BASE_URL']

  def initialize
    @auth = { username: ENV['TR_USER'], password: ENV['TR_SECRET_KEY'] }
  end

  def get_all_campaigns_quotes_and_qualifications(options = {})
    options.merge!({ basic_auth: @auth })
    response = HTTParty.get( BASE_URI + '/api/v1/campaigns.json', options)
    if response.code == 200
      campaigns = response.parsed_response
      campaigns.each do |c|
        campaign = Campaign.new
        campaign.id = c['id']
        campaign.length_of_interview = c['length_of_interview']
        campaign.cpi = c['cpi']
        campaign.name = c['name']

        response = HTTParty.get(BASE_URI + "/api/v1/campaigns/#{campaign.id}.json", options)
        if response.code == 200
          campaign_details = response.parsed_response
          campaign_details['campaign_quotas'].each do |quota|
            campaign_quota = campaign.campaign_quotas.build(
              num_respondents: quota['num_respondents']
            )
            quota['campaign_qualifications'].each do |qualifications|
              campaign_quota.campaign_qualifications.build(
                question_id: qualifications['question_id'],
                pre_codes: qualifications['pre_codes'].join(',')
              )
            end
          end
        else
          pp response.body
        end
        campaign.save!
      end
    else
      pp response.body
    end
  end

end
