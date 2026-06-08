require "test_helper"

class AffiliateTest < ActiveSupport::TestCase
  test "affiliate fixtures load correctly" do
    assert affiliates(:one).persisted?
    assert affiliates(:two).persisted?
  end

  test "affiliate has required attributes" do
    affiliate = affiliates(:one)
    assert_equal "Diego Mendoza", affiliate.name
    assert_equal "diego@example.com", affiliate.email
    assert_equal "active", affiliate.status
    assert_equal "REF001", affiliate.referral_code
  end

  test "affiliate can be created with valid attributes" do
    affiliate = Affiliate.new(
      name: "New Affiliate",
      email: "new@example.com",
      status: "active",
      referral_code: "REF999"
    )
    assert affiliate.save
    assert affiliate.persisted?
  end

  test "referral_code must be unique" do
    existing = affiliates(:one)
    duplicate = Affiliate.new(
      name: "Duplicate",
      email: "dup@example.com",
      status: "active",
      referral_code: existing.referral_code
    )
    assert_not duplicate.save
    assert_includes duplicate.errors[:referral_code], "has already been taken"
  end

  test "affiliate domains association" do
    affiliate = affiliates(:one)
    domain = affiliate.affiliate_domains.create!(
      domain: "newdomain.com",
      verification_method: "dns",
      verification_token: "tok-new",
      status: "pending"
    )
    assert_includes affiliate.affiliate_domains, domain
  end

  test "affiliate clicks association" do
    affiliate = affiliates(:one)
    click = affiliate.clicks.create!(
      offer: offers(:one),
      affiliate_domain: affiliate_domains(:one),
      referral_code: affiliate.referral_code,
      ip: "10.0.0.1",
      user_agent: "TestBot/1.0",
      request_id: "req-uniq-001",
      clicked_at: Time.current
    )
    assert_includes affiliate.clicks, click
  end

  test "affiliate conversions association" do
    affiliate = affiliates(:one)
    conversion = affiliate.conversions.create!(
      offer: offers(:one),
      click: clicks(:one),
      external_order_id: "ORDER-UNIQ-001",
      amount_cents: 2500,
      currency: "USD",
      status: "pending"
    )
    assert_includes affiliate.conversions, conversion
  end

  test "affiliate payouts association" do
    affiliate = affiliates(:one)
    payout = affiliate.payouts.create!(
      period_start: Time.current.beginning_of_month,
      period_end: Time.current.end_of_month,
      status: "pending",
      total_conversions: 0,
      total_amount_cents: 0,
      currency: "USD"
    )
    assert_includes affiliate.payouts, payout
  end
end
