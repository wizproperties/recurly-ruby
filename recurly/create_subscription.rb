#!/Users/benwisinski/.rbenv/versions/2.4.0/bin/ruby

puts 'starting...'

require 'rubygems'
require 'recurly'

Recurly.subdomain      = 'wizproperties'
Recurly.api_key        = 'b7ae615dc08e4c2398947d305def6ed3' #private key
#Recurly.api_key        = '9dc5244d81c04c848dd23748e5e073c7' #defualt key

# To set a default currency for your API requests:
Recurly.default_currency = 'USD'



class Subscription_Test

#creates a subscription on the account with the passed in account number
  def create_sub(account_number)
    begin
      accountNumber = account_number

      puts "Creating new subscription with account number: #{accountNumber}"

      subscription = Recurly::Subscription.create(
      :plan_code => 'shiny',
      :currency  => 'USD',
      :customer_notes  => 'Thank you for your business!',
      :account   => {
        :account_code => accountNumber,
        :billing_info => {
          :number => '4111-1111-1111-1111',
          :month  => 1,
          :year   => 2018,
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

      if subscription.errors.count > 0
            puts "subscription errors: #{subscription.errors}"
      end

      #Debugging output, to see if subscription count was increased.
      #resetting the account search in case it isnt updating the objects on the fly
      #account2 = Recurly::Account.find accountNumber
      #puts "subscriptions count: #{account2.subscriptions.count}"
      #account2.subscriptions.find_each do |subscription|
      #  puts "Subscription: #{subscription.inspect}"
      #end
    rescue Recurly::Resource::NotFound => e
      puts e.message
    rescue Recurly::API::UnprocessableEntity => e
      puts e.message
    end
  end

#counts the subscriptions on an account
  def sub_count(account_number)
    account = Recurly::Account.find account_number
    #puts account
    #puts "Account billing_info: #{account.billing_info}"
    puts "subscriptions count for #{account.account_code}: #{account.subscriptions.count}"
    account.subscriptions.count
  end

#creates an account from the passed account number with test data
  def create_account(account_number)
    begin
      #if account does not exist, a NotFound Error will be thrown
      accountNumber = account_number

      puts "Creating new account with account number: #{accountNumber}"

      account = Recurly::Account.create(
        :account_code => accountNumber,
        :email        => 'verena@example.com',
        :first_name   => 'Verena',
        :last_name    => 'Example',
          :shipping_addresses => [
            {
                :nickname => 'Work',
                  :first_name => 'Verena',
                  :last_name => 'Example',
                  :company => 'Recurly Inc',
                  :phone => '555-222-1212',
                  :email => 'verena@example.com',
                  :address1 => '123 Main St.',
                  :address2 => 'Suite 101',
                  :city => 'San Francisco',
                  :state => 'CA',
                  :zip => '94105',
                  :country => 'US'
              },
              {
                :nickname => 'Home',
                  :first_name => 'Verena',
                  :last_name => 'Example',
                  :phone => '555-867-5309',
                  :email => 'verena@example.com',
                  :address1 => '123 Fourth St.',
                  :address2 => 'Apt. 101',
                  :city => 'San Francisco',
                  :state => 'CA',
                  :zip => '94105',
                  :country => 'US'
              }
          ]
      )

      account = Recurly::Account.find(accountNumber)
      account.billing_info = {
        :first_name         => 'Verena',
        :last_name          => 'Example',
        :number             => '4111-1111-1111-1111',
        :verification_value => '123',
        :month              => 11,
        :year               => 2019,
        :address1           => '1234 fake st',
        :city               => 'Omaha',
        :state              => 'NE',
        :zip                => '68135',
        :country            => 'US'

      }
      account.billing_info.save!

      #output account to make sure it saved with billing_info
      #account = Recurly::Account.find accountNumber
      #puts "Account: #{account.inspect}"

    rescue Recurly::Resource::NotFound => e
      puts e.message
    rescue Recurly::API::UnprocessableEntity => e
      puts e.message
    end

  end
end
