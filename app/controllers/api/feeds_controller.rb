module Api
  class FeedsController < ApiController
    def create
      @feed = Feed.new(feed_params)

      if @feed.save
        @feed.get_posts
        render json: @feed
      else
        render json: @feed.errors.full_messages, status: :unprocessable_entity
      end
    end

    def index
      @feeds = Feed.all
      render json: @feeds
    end

    def show
      @feed = Feed.includes(:posts).find(params[:id])
      render :show
    end

    private

    def feed_params
      params.require(:feed).permit(:ig_user, :country_id, :category_id)
    end
  end
end
