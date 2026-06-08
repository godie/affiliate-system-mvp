require "test_helper"

class AttributionServiceTest < ActiveSupport::TestCase
  test "call does not raise for a valid conversion" do
    conversion = conversions(:one)
    assert_nothing_raised do
      AttributionService.call(conversion)
    end
  end

  test "call accepts a conversion record" do
    conversion = conversions(:one)
    result = AttributionService.call(conversion)
    assert_nil result # service is a stub, returns nil
  end

  test "call accepts a new unsaved conversion" do
    conversion = Conversion.new(
      affiliate: affiliates(:one),
      offer: offers(:one),
      click: clicks(:one),
      external_order_id: "ORDER-SVC-001",
      amount_cents: 3000,
      currency: "USD",
      status: "pending"
    )
    assert_nothing_raised do
      AttributionService.call(conversion)
    end
  end
end
