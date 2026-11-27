module ApplicationHelper
  def page_dir
    I18n.locale == :fa ? "rtl" : "ltr"
  end

  def page_lang
    I18n.locale.to_s
  end

  def brand_name
    "LinkPulse"
  end
end
