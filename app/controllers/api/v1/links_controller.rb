module Api
  module V1
    class LinksController < ActionController::API
      def index
        links = Link.order(created_at: :desc)
        render json: links.map { |link| serialize_link(link) }
      end

      def show
        link = Link.find_by(id: params[:id]) || Link.find_by(short_code: params[:id])
        return render json: { error: "Link not found" }, status: :not_found unless link

        render json: serialize_link(link).merge(
          browsers: link.click_events.group_by(&:browser_name).transform_values(&:count),
          devices: link.click_events.group_by(&:device_type).transform_values(&:count)
        )
      end

      def create
        link = Link.new(link_params)
        if link.save
          render json: serialize_link(link), status: :created
        else
          render json: { errors: link.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        link = Link.find_by(id: params[:id]) || Link.find_by(short_code: params[:id])
        return render json: { error: "Link not found" }, status: :not_found unless link

        link.destroy
        head :no_content
      end

      private

      def link_params
        params.require(:link).permit(:original_url, :short_code)
      end

      def serialize_link(link)
        {
          id: link.id,
          original_url: link.original_url,
          short_code: link.short_code,
          short_url: short_url(link.short_code),
          clicks_count: link.clicks_count,
          created_at: link.created_at
        }
      end
    end
  end
end
