require "test_helper"

class LinkTest < ActiveSupport::TestCase
  test "generates a 6-character short code when blank" do
    link = Link.create!(original_url: "https://www.ruby-lang.org")
    assert_equal 6, link.short_code.length
    assert_equal 0, link.clicks_count
  end

  test "rejects invalid URL schemes" do
    link = Link.new(original_url: "javascript:alert(1)")
    assert_not link.valid?
    assert link.errors[:original_url].any?
  end

  test "rejects reserved short codes" do
    link = Link.new(original_url: "https://example.com", short_code: "locale")
    assert_not link.valid?
    assert link.errors[:short_code].any?
  end

  test "enforces unique short codes" do
    duplicate = Link.new(original_url: "https://example.com", short_code: links(:one).short_code)
    assert_not duplicate.valid?
  end
end
