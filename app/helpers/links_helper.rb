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

  def top_referrers_summary(link, limit: 5)
    return [] unless link.respond_to?(:click_events)

    link.click_events
        .group(:referrer)
        .count
        .transform_keys { |ref| ref.presence || "Direct" }
        .sort_by { |_k, v| -v }
        .first(limit)
  end
end
