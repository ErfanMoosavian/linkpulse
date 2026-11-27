class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = Link.order(created_at: :desc)
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to root_path, notice: t("links.notices.created", url: short_url(@link.short_code))
    else
      @links = Link.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @link = Link.find(params[:id])
    @click_events = @link.click_events.order(created_at: :desc).limit(50)
    @browser_stats = @link.click_events.group_by(&:browser_name).transform_values(&:count).sort_by { |_, count| -count }
    @device_stats = @link.click_events.group_by(&:device_type).transform_values(&:count).sort_by { |_, count| -count }
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to root_path, notice: t("links.notices.deleted")
  end

  private

  def link_params
    params.require(:link).permit(:original_url, :short_code)
  end
end
