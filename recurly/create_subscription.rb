#!/Users/benwisinski/.rbenv/versions/2.4.0/bin/ruby

puts 'starting...'

require 'rubygems'
require 'recurly'

Recurly.subdomain      = 'wizproperties'
Recurly.api_key        = 'b7ae615dc08e4c2398947d305def6ed3' #private key
#Recurly.api_key        = '9dc5244d81c04c848dd23748e5e073c7' #defualt key

# To set a default currency for your API requests:
Recurly.default_currency = 'USD'


begin
  #if account does not exist, a NotFound Error will be thrown
  account = Recurly::Account.find '1234'
  #puts account
  #puts "Account billing_info: #{account.billing_info}"
  puts "subscriptions count: #{account.subscriptions.count}"

  account.subscriptions.find_each do |subscription|
    puts "Subscription: #{subscription.inspect}"
  end
  #subscription will fail because a plan_code is not set
  #subscription = Recurly::Subscription.create!(:account => account)

  #wothless comment to test git

rescue Recurly::Resource::NotFound => e
  puts e.message
rescue Recurly::API::UnprocessableEntity => e
  puts e.message
else
  puts "Successfully Created"
end

=begin
subscription = Recurly::Subscription.create(
  :plan_code => 'gold',
  :currency  => 'EUR',
  :customer_notes  => 'Thank you for your business!',
  :account   => {
    :account_code => '1',
    :email        => 'verena@example.com',
    :first_name   => 'Verena',
    :last_name    => 'Example',
    :billing_info => {
      :number => '4111-1111-1111-1111',
      :month  => 1,
      :year   => 2014,
    }
  },
  :shipping_address => {
    :nickname   => 'Work',
    :first_name => 'Verena',
    :last_name  => 'Example',
    :company    => 'Recurly Inc',
    :phone      => '555-222-1212',
    :email      => 'verena@example.com',
    :address1   => '123 Main St.',
    :address2   => 'Suite 101',
    :city       => 'San Francisco',
    :state      => 'CA',
    :zip        => '94105',
    :country    => 'US'
  }
)
=end


class Subscription_Test
  def create_sub(account_number)
  end

  def sub_count
    0
  end
end
