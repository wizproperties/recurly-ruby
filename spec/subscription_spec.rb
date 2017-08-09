require "../recurly/create_subscription"

RSpec.describe Subscription_Test do
  describe "#sub_count" do
    it "Tests counts of subscriptions found against a fresh account" do
      sub_test = Subscription_Test.new
      accountNumber = "1234"
      sub_test.create_account(accountNumber)
      expect(sub_test.sub_count(accountNumber)).to eq(0)
      sub_test.create_sub(accountNumber)
      expect(sub_test.sub_count(accountNumber)).to eq(1)
    end
  end
end
