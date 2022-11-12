class ImagesController < ApplicationController
  def create
    image_request = ImageRequest.find(params[:image_request_id])
    image_request.retrieve_image!
    redirect_to root_path
  end
end
