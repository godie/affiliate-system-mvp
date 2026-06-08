require "test_helper"

class ClickTest < ActiveSupport::TestCase
  test "click fixtures load correctly" do
    assert clicks(:one).persisted?
    assert clicks(:two).persisted?
  end

  test "click belongs to affiliate" do
    click = clicks(:one)
    assert_equal affiliates(:one), click.affiliate
  end

  test "click belongs to offer" do
    click = clicks(:one)
    assert_equal offers(:one), click.offer
  end

  test "click belongs to affiliate_domain" do
    click = clicks(:one)
    assert_equal affiliate_domains(:one), click.affiliate_domain
  end

  test "click has required attributes" do
    click = clicks(:one)
    assert_equal "REF001", click.referral_code
    assert_equal "192.168.1.1", click.ip
    assert_equal "Mozilla/5.0", click.user_agent
    assert_equal "https://example.com", click.referer
    assert_equal "req-abc-111", click.request_id
    assert_not_nil click.clicked_at
  end

  test "click can be created with valid attributes" do
    click = Click.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      affiliate_domain: affiliate_domains(:one),
      referral_code: "REF001",
      ip: "10.0.0.99",
      user_agent: "TestAgent/2.0",
      request_id: "req-new-001",
      clicked_at: Time.current
    )
    assert click.save
    assert click.persisted?
  end

  test "click requires affiliate" do
    click = Click.new(
      offer: offers(:one),
      affiliate_domain: affiliate_domains(:one),
      referral_code: "REF001",
      ip: "10.0.0.1",
      request_id: "req-no-aff",
      clicked_at: Time.current
    )
    assert_not click.save
    assert_includes click.errors[:affiliate], "must exist"
  end

  test "click requires offer" do
    click = Click.new(
      affiliate: affiliates(:one),
      affiliate_domain: affiliate_domains(:one),
      referral_code: "REF001",
      ip: "10.0.0.1",
      request_id: "req-no-offer",
      clicked_at: Time.current
    )
    assert_not click.save
    assert_includes click.errors[:offer], "must exist"
  end

  test "click requires affiliate_domain" do
    click = Click.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      referral_code: "REF001",
      ip: "10.0.0.1",
      request_id: "req-no-domain",
      clicked_at: Time.current
    )
    assert_not click.save
    assert_includes click.errors[:affiliate_domain], "must exist"
  end

  test "click conversions association" do
    click = clicks(:one)
    conversion = click.conversions.create!(
      affiliate: affiliates(:one),
      offer: offers(:one),
      external_order_id: "ORDER-CLICK-001",
      amount_cents: 4000,
      currency: "USD",
      status: "pending"
    )
    assert_includes click.conversions, conversion
  end
end
