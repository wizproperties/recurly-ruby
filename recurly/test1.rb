#!/Users/benwisinski/.rbenv/versions/2.4.0/bin/ruby

puts 'starting...'

require 'rubygems'
require 'recurly'

Recurly.subdomain      = 'wizproperties'
Recurly.api_key        = 'b7ae615dc08e4c2398947d305def6ed3' #private key
#Recurly.api_key        = '9dc5244d81c04c848dd23748e5e073c7' #defualt key

# To set a default currency for your API requests:
Recurly.default_currency = 'USD'

Recurly::Subscription.find_each do |subscription|
  puts "Susbcription: #{subscription}"
end
