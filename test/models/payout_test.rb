require "test_helper"

class PayoutTest < ActiveSupport::TestCase
  test "payout fixtures load correctly" do
    assert payouts(:one).persisted?
    assert payouts(:two).persisted?
  end

  test "payout belongs to affiliate" do
    payout = payouts(:one)
    assert_equal affiliates(:one), payout.affiliate
  end

  test "payout has required attributes" do
    payout = payouts(:one)
    assert_equal "pending", payout.status
    assert_equal 1, payout.total_conversions
    assert_equal 5000, payout.total_amount_cents
    assert_equal "USD", payout.currency
    assert_not_nil payout.period_start
    assert_not_nil payout.period_end
  end

  test "payout can be created with valid attributes" do
    payout = Payout.new(
      affiliate: affiliates(:one),
      period_start: Time.current.beginning_of_month,
      period_end: Time.current.end_of_month,
      status: "pending",
      total_conversions: 0,
      total_amount_cents: 0,
      currency: "USD"
    )
    assert payout.save
    assert payout.persisted?
  end

  test "payout requires affiliate" do
    payout = Payout.new(
      period_start: Time.current,
      period_end: Time.current,
      status: "pending",
      total_conversions: 0,
      total_amount_cents: 0,
      currency: "USD"
    )
    assert_not payout.save
    assert_includes payout.errors[:affiliate], "must exist"
  end

  test "payout total_conversions is nil if not set" do
    payout = Payout.new(
      affiliate: affiliates(:one),
      period_start: Time.current,
      period_end: Time.current,
      status: "pending",
      total_amount_cents: 0,
      currency: "USD"
    )
    assert payout.save
    assert_nil payout.total_conversions
  end

  test "payout total_amount_cents must be non-negative" do
    payout = Payout.new(
      affiliate: affiliates(:one),
      period_start: Time.current,
      period_end: Time.current,
      status: "pending",
      total_conversions: 1,
      total_amount_cents: -100,
      currency: "USD"
    )
    assert_not payout.save
  end

  test "payout payout_items association" do
    payout = payouts(:one)
    item = payout.payout_items.create!(
      conversion: conversions(:one),
      amount_cents: 5000
    )
    assert_includes payout.payout_items, item
  end
end
