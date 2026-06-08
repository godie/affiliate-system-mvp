require "test_helper"

class PayoutItemTest < ActiveSupport::TestCase
  test "payout item fixtures load correctly" do
    assert payout_items(:one).persisted?
    assert payout_items(:two).persisted?
  end

  test "payout item belongs to payout" do
    item = payout_items(:one)
    assert_equal payouts(:one), item.payout
  end

  test "payout item belongs to conversion" do
    item = payout_items(:one)
    assert_equal conversions(:one), item.conversion
  end

  test "payout item has required attributes" do
    item = payout_items(:one)
    assert_equal 5000, item.amount_cents
  end

  test "payout item can be created with valid attributes" do
    item = PayoutItem.new(
      payout: payouts(:one),
      conversion: conversions(:one),
      amount_cents: 3000
    )
    assert item.save
    assert item.persisted?
  end

  test "payout item requires payout" do
    item = PayoutItem.new(
      conversion: conversions(:one),
      amount_cents: 1000
    )
    assert_not item.save
    assert_includes item.errors[:payout], "must exist"
  end

  test "payout item requires conversion" do
    item = PayoutItem.new(
      payout: payouts(:one),
      amount_cents: 1000
    )
    assert_not item.save
    assert_includes item.errors[:conversion], "must exist"
  end

  test "payout item amount_cents must be non-negative" do
    item = PayoutItem.new(
      payout: payouts(:one),
      conversion: conversions(:one),
      amount_cents: -500
    )
    assert_not item.save
  end
end
