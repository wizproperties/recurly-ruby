require "../recurly/create_subscription"

RSpec.describe Subscription_Test do
  describe "#score" do
    it "returns 0 for an all gutter game" do
      sub_test = Subscription_Test.new
      expect(sub_test.sub_count).to eq(0)
    end
  end
end
