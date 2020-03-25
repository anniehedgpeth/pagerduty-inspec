require 'HTTParty'

API_TOKEN = '***'
ENDPOINT = 'https://api.pagerduty.com/users'
TOKEN_STRING = "Token token=#{API_TOKEN}"

query = HTTParty.get(
  ENDPOINT,
  headers: {
    'Authorization'=> "Token token=#{API_TOKEN}",
    'Accept'=> 'application/vnd.pagerduty+json;version=2',
  }
)

puts query