require "test_helper"

class OfferTest < ActiveSupport::TestCase
  test "offer fixtures load correctly" do
    assert offers(:one).persisted?
    assert offers(:two).persisted?
  end

  test "offer has required attributes" do
    offer = offers(:one)
    assert_equal "Summer Sale", offer.name
    assert_equal "summer-sale", offer.slug
    assert_equal 500, offer.payout_cents
    assert_equal "USD", offer.currency
    assert_equal "active", offer.status
    assert_equal 86_400, offer.attribution_window_seconds
  end

  test "offer can be created with valid attributes" do
    offer = Offer.new(
      name: "Spring Deal",
      slug: "spring-deal",
      payout_cents: 750,
      currency: "USD",
      status: "active",
      attribution_window_seconds: 43_200
    )
    assert offer.save
    assert offer.persisted?
  end

  test "offer clicks association" do
    offer = offers(:one)
    click = offer.clicks.create!(
      affiliate: affiliates(:one),
      affiliate_domain: affiliate_domains(:one),
      referral_code: "REF001",
      ip: "10.0.0.1",
      user_agent: "TestBot/1.0",
      request_id: "req-offer-001",
      clicked_at: Time.current
    )
    assert_includes offer.clicks, click
  end

  test "offer conversions association" do
    offer = offers(:one)
    conversion = offer.conversions.create!(
      affiliate: affiliates(:one),
      click: clicks(:one),
      external_order_id: "ORDER-OFFER-001",
      amount_cents: 3000,
      currency: "USD",
      status: "pending"
    )
    assert_includes offer.conversions, conversion
  end

  test "offer payout cents must be a positive integer" do
    offer = Offer.new(
      name: "Bad Offer",
      slug: "bad-offer",
      payout_cents: -100,
      currency: "USD",
      status: "active",
      attribution_window_seconds: 3600
    )
    assert_not offer.save
  end

  test "offer attribution window must be present" do
    offer = Offer.new(
      name: "No Window",
      slug: "no-window",
      payout_cents: 100,
      currency: "USD",
      status: "active"
    )
    assert_not offer.save
  end
end
