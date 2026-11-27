require "test_helper"

class LinksFlowTest < ActionDispatch::IntegrationTest
  test "redirects short code with 302 and tracks click analytics" do
    link = links(:two)
    assert_difference -> { link.click_events.count }, 1 do
      get short_url(link.short_code), headers: { "User-Agent" => "Mozilla/5.0 Firefox/126.0" }
    end
    assert_response :found
    assert_redirected_to link.original_url
    assert_equal 1, link.reload.clicks_count
  end

  test "switches UI language between English and Persian with RTL direction" do
    get switch_locale_url(:fa)
    assert_response :redirect

    get root_url
    assert_response :success
    assert_includes response.body, 'dir="rtl"'
    assert_includes response.body, "ساخت لینک کوتاه جدید"

    get switch_locale_url(:en)
    get root_url
    assert_includes response.body, 'dir="ltr"'
    assert_includes response.body, "Create a Short Link"
  end

  test "creates and fetches links via JSON API" do
    assert_difference "Link.count", 1 do
      post api_v1_links_url,
           params: { link: { original_url: "https://guides.rubyonrails.org", short_code: "railsguide" } },
           as: :json
    end
    assert_response :created
    body = JSON.parse(response.body)
    assert_equal "railsguide", body["short_code"]

    get api_v1_link_url("railsguide"), as: :json
    assert_response :success
    stats = JSON.parse(response.body)
    assert_equal 0, stats["clicks_count"]
  end
end
