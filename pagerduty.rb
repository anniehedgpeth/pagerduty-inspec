# /usr/bin/env ruby

require 'httparty'
require 'json'

node = 'PD-Demo'

failed = 0
passed = 0

output = File.read('output.json')
output_hash = JSON.parse(output)
failures = []

output_hash['controls'].each do |details|
  status = details['status']
  if status == 'failed'
    failed += 1
    failures << details['code_desc']
  else
    passed += 1
  end
end

total = failed + passed

inspec_details = ''
failures.each do |desc|
  inspec_details += "#{desc}\n"
end

inspec_details += %(
  #{failed} Failed Controls
  #{passed} Successful Controls
  #{total} Total Controls\n
)

puts inspec_details

profile = output_hash['profiles'][0]['name']
puts "Profile '#{profile}'"
puts "Receiving JSON output for profile '#{profile}' on node '#{node}'"

inspec_desc = "FAILURE for '#{profile}' on #{node} - #{failed} Failed Controls"

if failed == 0
  puts 'Success! All of your InSpec Controls passed.'
else
  puts inspec_desc
  puts 'Sending failure status to PagerDuty'

  API_TOKEN = '***'.freeze
  SERVICE_KEY = '***'.freeze

  ENDPOINT = 'https://events.pagerduty.com/generic/2010-04-15/create_event.json'.freeze
  TOKEN_STRING = "Token token=#{API_TOKEN}".freeze

  data = {
    service_key: SERVICE_KEY,
    event_type: 'trigger',
    description: inspec_desc,
    client: 'InSpec',
    details: inspec_details
  }

  response = HTTParty.post(
    ENDPOINT,
    body: data.to_json,
    headers: {
      'Content-Type' => 'application/json', 'Authorization' => TOKEN_STRING
    }
  )

  puts response.body
end
