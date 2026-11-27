class RedirectsController < ApplicationController
  def show
    @link = Link.find_by(short_code: params[:short_code])
    if @link
      @link.click_events.create(
        user_agent: request.user_agent,
        referer: request.referer
      )
      @link.increment!(:clicks_count)
      redirect_to @link.original_url, allow_other_host: true, status: :found
    else
      redirect_to root_path, alert: t("links.notices.not_found")
    end
  end
end
