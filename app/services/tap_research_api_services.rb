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
      raise response.body
    end
  end

end
