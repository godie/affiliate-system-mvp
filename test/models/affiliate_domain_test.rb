require "test_helper"

class AffiliateDomainTest < ActiveSupport::TestCase
  test "affiliate domain fixtures load correctly" do
    assert affiliate_domains(:one).persisted?
    assert affiliate_domains(:two).persisted?
  end

  test "affiliate domain belongs to affiliate" do
    domain = affiliate_domains(:one)
    assert_equal affiliates(:one), domain.affiliate
  end

  test "affiliate domain has required attributes" do
    domain = affiliate_domains(:one)
    assert_equal "example.com", domain.domain
    assert_equal "dns", domain.verification_method
    assert_equal "tok-abc-123", domain.verification_token
    assert_equal "verified", domain.status
    assert_not_nil domain.verified_at
  end

  test "affiliate domain can be created with valid attributes" do
    domain = AffiliateDomain.new(
      affiliate: affiliates(:one),
      domain: "new-site.com",
      verification_method: "file",
      verification_token: "tok-new-789",
      status: "pending"
    )
    assert domain.save
    assert domain.persisted?
  end

  test "affiliate domain clicks association" do
    domain = affiliate_domains(:one)
    click = domain.clicks.create!(
      affiliate: affiliates(:one),
      offer: offers(:one),
      referral_code: "REF001",
      ip: "10.0.0.1",
      user_agent: "TestBot/1.0",
      request_id: "req-ad-001",
      clicked_at: Time.current
    )
    assert_includes domain.clicks, click
  end

  test "affiliate domain requires affiliate" do
    domain = AffiliateDomain.new(
      domain: "orphan.com",
      verification_method: "dns",
      verification_token: "tok-orphan",
      status: "pending"
    )
    assert_not domain.save
    assert_includes domain.errors[:affiliate], "must exist"
  end
end
