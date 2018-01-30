# if Rails.env.development?
# active_campaign = ActiveCampaign.new(
#           api_endpoint: ENV['ACTIVECAMPAIGN_URL'], # e.g. 'https://yourendpoint.api-us1.com'
#           api_key: ENV['ACTIVECAMPAIGN_KEY']) # e.g. 'a4e60a1ba200595d5cc37ede5732545184165e'
# end

# ::ActiveCampaign.configure do |config|
#   config.api_endpoint = ENV['ACTIVECAMPAIGN_URL'], # e.g. 'https://yourendpoint.api-us1.com/admin/api.php'
#   config.api_key = ENV['ACTIVECAMPAIGN_KEY'] # e.g. 'a4e60a1ba200595d5cc37ede5732545184165e'
# end

#result = JSON.parse active_campaign_client.contact_list({'filters[email]' => "#{parent_email}"})

# ac = ActiveCampaign.new(api_endpoint: ENV['ACTIVECAMPAIGN_URL'], api_key: ENV['ACTIVECAMPAIGN_KEY'], api_output: 'serialize')
# active_campaign.contact_list ({'filters[first_name]' => 'Raj'})
# hash = JSON.parse a
# hash["result_code"]
# active_campaign.contact_tag_add({"id" => 1, "tags" => "APITEST"})
# contact = active_campaign.contact_list({'filters[email]' => 'raj@mathplusacademy.com'})
# hash["0"]["email"]
#  => "raj@mathplusacademy.com"
# hash = JSON.parse contact
# hash["result_code"]
#  => {"result_code"=>0, "result_message"=>"Failed: Nothing is returned", "result_output"=>"json"}
