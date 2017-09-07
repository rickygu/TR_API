class TapResearchApiServices
  include HTTParty
  base_uri ENV['TR_BASE_URL']

  def initialize
    @auth = { username: ENV['TR_USER'], password: ENV['TR_SECRET_KEY'] }
  end


  def get_all_campaigns(options = {})
    options.merge!({ basic_auth: @auth })
    response = self.class.get('/api/v1/campaigns.json', options)
    if response.code == 200
      campaigns = JSON.parse response.body
      campaigns.each do |c|
        campaign = Campaign.new
        campaign.id = c['id']
        campaign.length_of_interview = c['length_of_interview']
        campaign.cpi = c['cpi']
        campaign.name = c['name']
        campaign.save!
      end
    else
      pp response.body
    end
  end

  def get_all_quotas_and_qualifications(options = {})
    options.merge!({ basic_auth: @auth })
    Campaign.all.each do |campaign|
      uri = "/api/v1/campaigns/#{campaign.id}.json"
      response = self.class.get(uri, options)
      if response.code == 200
        campaign_details = JSON.parse response.body
        campaign_details['campaign_quotas'].each do |quota|
          campaign_quota = campaign.campaign_quotas.create(
            num_respondents: quota['num_respondents']
          )
          quota['campaign_qualifications'].each do |qualifications|
            campaign_quota.campaign_qualifications.create(
              question_id: qualifications['question_id'],
              pre_codes: qualifications['pre_codes'].join(',')
            )
          end
        end
      else
        pp response.body
      end
    end

  end
end
