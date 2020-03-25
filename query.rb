require 'HTTParty'

API_TOKEN = 'yKjW-NynjsB1cNsRVYZs'
ENDPOINT = 'https://api.pagerduty.com/users'
TOKEN_STRING = "Token token=#{API_TOKEN}"

query = HTTParty.get(
  ENDPOINT,
  headers: {
    'Authorization'=> 'Token token=y_NbAkKc66ryYTWUXYEu',
    'Accept'=> 'application/vnd.pagerduty+json;version=2',
  }
)

puts query