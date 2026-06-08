require "test_helper"

class ConversionTest < ActiveSupport::TestCase
  test "conversion fixtures load correctly" do
    assert conversions(:one).persisted?
    assert conversions(:two).persisted?
  end

  test "conversion belongs to affiliate" do
    conversion = conversions(:one)
    assert_equal affiliates(:one), conversion.affiliate
  end

  test "conversion belongs to offer" do
    conversion = conversions(:one)
    assert_equal offers(:one), conversion.offer
  end

  test "conversion belongs to click" do
    conversion = conversions(:one)
    assert_equal clicks(:one), conversion.click
  end

  test "conversion has required attributes" do
    conversion = conversions(:one)
    assert_equal "ORDER-111", conversion.external_order_id
    assert_equal 5000, conversion.amount_cents
    assert_equal "USD", conversion.currency
    assert_equal "attributed", conversion.status
    assert_not_nil conversion.attributed_at
  end

  test "conversion can be created with valid attributes" do
    conversion = Conversion.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      click: clicks(:one),
      external_order_id: "ORDER-NEW-001",
      amount_cents: 7500,
      currency: "USD",
      status: "pending"
    )
    assert conversion.save
    assert conversion.persisted?
  end

  test "conversion requires affiliate" do
    conversion = Conversion.new(
      offer: offers(:one),
      click: clicks(:one),
      external_order_id: "ORDER-NO-AFF",
      amount_cents: 1000,
      currency: "USD",
      status: "pending"
    )
    assert_not conversion.save
    assert_includes conversion.errors[:affiliate], "must exist"
  end

  test "conversion requires offer" do
    conversion = Conversion.new(
      affiliate: affiliates(:one),
      click: clicks(:one),
      external_order_id: "ORDER-NO-OFFER",
      amount_cents: 1000,
      currency: "USD",
      status: "pending"
    )
    assert_not conversion.save
    assert_includes conversion.errors[:offer], "must exist"
  end

  test "conversion requires click" do
    conversion = Conversion.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      external_order_id: "ORDER-NO-CLICK",
      amount_cents: 1000,
      currency: "USD",
      status: "pending"
    )
    assert_not conversion.save
    assert_includes conversion.errors[:click], "must exist"
  end

  test "conversion amount_cents must be non-negative" do
    conversion = Conversion.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      click: clicks(:one),
      external_order_id: "ORDER-NEG",
      amount_cents: -500,
      currency: "USD",
      status: "pending"
    )
    assert_not conversion.save
  end
end
