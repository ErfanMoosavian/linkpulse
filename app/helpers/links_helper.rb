module LinksHelper
  def short_url_for(link)
    "#{request.base_url}/#{link.slug}"
  end

  def formatted_clicks_count(link)
    number_with_delimiter(link.clicks_count.to_i)
  end

  def link_direction_attr
    I18n.locale == :fa ? "rtl" : "ltr"
  end

  def formatted_created_at(record)
    return "" unless record.respond_to?(:created_at) && record.created_at

    record.created_at.strftime("%Y-%m-%d %H:%M")
  end

  def link_status_label(link)
    return t("links.expired", default: "Expired") if link.respond_to?(:expired?) && link.expired?

    t("links.active", default: "Active")
  end

  def top_referrers_summary(link, limit: 5)
    return [] unless link.respond_to?(:click_events)

    link.click_events
        .group(:referrer)
        .count
        .transform_keys { |ref| ref.presence || "Direct" }
        .sort_by { |_k, v| -v }
        .first(limit)
  end

  def daily_clicks_rows(link)
    report = LinkAnalyticsReport.new(link)
    report.clicks_by_day.sort_by { |date, _count| date }.reverse
  end
end
