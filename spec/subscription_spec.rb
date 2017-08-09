require "../recurly/create_subscription"

RSpec.describe Subscription_Test do
  describe "#sub_count" do
    it "returns count of subscriptions found against a fresh account" do
      sub_test = Subscription_Test.new
      sub_test.create_account("1235")
      expect(sub_test.sub_count("1235")).to eq(0)
      sub_test.create_sub("1235")
      expect(sub_test.sub_count("1235")).to eq(1)
    end
  end
end
