class HomeController < ApplicationController
  def index
    @image_requests = ImageRequest.all
  end
end
