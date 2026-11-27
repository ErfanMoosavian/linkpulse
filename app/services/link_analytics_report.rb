class LinkAnalyticsReport
  def initialize(link)
    @link = link
  end

  def total_clicks
    @link.clicks_count.to_i
  end

  def clicks_by_day
    return {} unless @link.respond_to?(:click_events)

    @link.click_events.group_by { |e| e.created_at.to_date.to_s }.transform_values(&:count)
  end

  def top_referrers(limit: 5)
    return {} unless @link.respond_to?(:click_events)

    @link.click_events
         .group(:referrer)
         .count
         .transform_keys { |r| r.presence || "Direct" }
         .sort_by { |_k, v| -v }
         .first(limit)
         .to_h
  end
end
