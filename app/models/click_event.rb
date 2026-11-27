class ClickEvent < ApplicationRecord
  belongs_to :link

  def browser_name
    ua = user_agent.to_s
    return "Edge" if ua.include?("Edg")
    return "Opera" if ua.include?("OPR") || ua.include?("Opera")
    return "Chrome" if ua.include?("Chrome")
    return "Firefox" if ua.include?("Firefox")
    return "Safari" if ua.include?("Safari")
    "Other"
  end

  def device_type
    ua = user_agent.to_s
    return "Mobile" if ua.match?(/Mobile|Android|iPhone/i)
    return "Tablet" if ua.match?(/iPad|Tablet/i)
    "Desktop"
  end
end
