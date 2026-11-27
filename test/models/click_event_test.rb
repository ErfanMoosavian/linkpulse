require "test_helper"

class ClickEventTest < ActiveSupport::TestCase
  test "detects browser and device type from user agent" do
    event = ClickEvent.new(
      link: links(:one),
      user_agent: "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1 Mobile/15E148"
    )
    assert_equal "Safari", event.browser_name
    assert_equal "Mobile", event.device_type
  end
end
