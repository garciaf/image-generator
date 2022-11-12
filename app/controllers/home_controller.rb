class HomeController < ApplicationController
  def index
    @image_requests = ImageRequest.order(created_at: :desc).all
  end
end
