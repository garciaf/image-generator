class HomeController < ApplicationController
  def index
    @image_requests = ImageRequest.includes(:synced_generated_images).all
  end
end
