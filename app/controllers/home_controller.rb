class HomeController < ApplicationController
  def index
    @image_requests = ImageRequest
                      .with_attached_images
                      .order(created_at: :desc)
                      .paginate(
                        page: params[:page],
                        per_page: 5
                      )
  end
end
