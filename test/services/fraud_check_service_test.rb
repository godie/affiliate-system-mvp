require "test_helper"

class FraudCheckServiceTest < ActiveSupport::TestCase
  test "call does not raise for a valid click" do
    click = clicks(:one)
    assert_nothing_raised do
      FraudCheckService.call(click)
    end
  end

  test "call accepts a click record" do
    click = clicks(:one)
    result = FraudCheckService.call(click)
    assert_nil result # service is a stub, returns nil
  end

  test "call accepts a hash event" do
    event = { ip: "192.168.1.1", user_agent: "TestBot/1.0", referral_code: "REF001" }
    assert_nothing_raised do
      FraudCheckService.call(event)
    end
  end

  test "call accepts a new unsaved click" do
    click = Click.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      affiliate_domain: affiliate_domains(:one),
      referral_code: "REF001",
      ip: "10.0.0.1",
      request_id: "req-fraud-001",
      clicked_at: Time.current
    )
    assert_nothing_raised do
      FraudCheckService.call(click)
    end
  end
end
