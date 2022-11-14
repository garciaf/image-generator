class HomeController < ApplicationController
  def index
    @image_requests = ImageRequest.with_attached_images.order(created_at: :desc).all
  end
end
