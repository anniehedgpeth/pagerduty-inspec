chef exec inspec exec https://github.com/dev-sec/linux-baseline -t ssh://annie@pd-demo.southcentralus.cloudapp.azure.com -i ~/.ssh/id_rsa
chef exec inspec exec https://github.com/dev-sec/linux-baseline -t ssh://annie@pd-demo.southcentralus.cloudapp.azure.com -i ~/.ssh/id_rsa --format=json > output.json
ruby pagerduty.rb