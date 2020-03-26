require 'HTTParty'
require 'json'

API_TOKEN = '***'
TOKEN_STRING = "Token token=#{API_TOKEN}"

def query(endpoint)
  user_query = HTTParty.get(
    endpoint,
    headers: {
      'Authorization'=> TOKEN_STRING,
      'Accept'=> 'application/vnd.pagerduty+json;version=2',
    }
  )
end

# Get a list of users
user_query = query('https://api.pagerduty.com/users')
users = user_query['users']

no_phone_user_ids = []

# Gather all of the IDs of the users that don't have a phone as a contact method 
users.each do |user|
  id = user['id']
  contact_method_query = query("https://api.pagerduty.com/users/#{id}/contact_methods")
  unless contact_method_query['contact_methods'].any? { |n| n['type'] == 'phone_contact_method' }
    no_phone_user_ids << id
  end
end

no_phone_folks = []

# Use those IDs to get the names of all of the people that don't have a phone as a contact method
no_phone_user_ids.each do |n|
  no_phone_user_hash = query("https://api.pagerduty.com/users/#{n}")
  no_phone_folks << no_phone_user_hash['user']['name']
end

puts 'The following people do not have a phone as a contact method:'
puts no_phone_folks
